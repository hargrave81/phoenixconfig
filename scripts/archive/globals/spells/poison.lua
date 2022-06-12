-----------------------------------------
--   Spell: Poison
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local currentResist = target:getMod(xi.mod.POISONRES)
    if currentResist == nil then
        currentResist = 0
    end

    local skill = caster:getSkillLevel(xi.skill.ENFEEBLING_MAGIC)
    local power = math.max(skill / 25, 1)
    if skill > 400 then
        power = math.min((skill - 225) / 5, 55) -- Cap is 55 hp/tick
    end
    power = calculatePotency(power, spell:getSkillType(), caster, target)

    local duration = calculateDuration(30, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    if resist >= 0.5 then -- effect taken
        if target:addStatusEffect(params.effect, power, 3, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.POISONRES, currentResist + 5)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else -- resist entirely.
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end