-----------------------------------------
-- Spell: Slow II
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)
    local merits = caster:getMerit(xi.merit.SLOW_II)

    local currentResist = target:getMod(xi.mod.SLOWRES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Lowest ~12.5%
    -- Highest ~35.1%
    local power = utils.clamp(math.floor(dMND * 226 / 15) + 2380, 1250, 3510)
    power = calculatePotency(power, spell:getSkillType(), caster, target)

    if merits > 1 then
        power = power + merits - 1
    end

    --Duration, including resistance.
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = merits * 2
    params.effect = xi.effect.SLOW
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(params.effect, power, 0, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.SLOWRES, currentResist + 10)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end