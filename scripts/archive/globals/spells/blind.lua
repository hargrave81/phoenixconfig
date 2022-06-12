-----------------------------------------
-- Spell: Blind
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
    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.MND) -- blind uses caster INT vs target MND

    local currentResist = target:getMod(xi.mod.BLINDRES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Base power
    -- Min cap: 5 at -80 dINT
    -- Max cap: 50 at 120 dINT
    local basePotency = utils.clamp(math.floor(dINT * 9 / 40 + 23), 5, 50)
    local potency = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(params.effect, potency, 0 , duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.BLINDRES, currentResist + 10)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end