-----------------------------------------
-- Spell: Blind II
-- caster:getMerit() returns a value which is equal to the number of merit points TIMES the value of each point
-- Blind II value per point is '1' This is a constant set in the table 'merits'
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
    local merits = caster:getMerit(xi.merit.BLIND_II)

    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.MND) -- blind uses caster INT vs target MND


    local currentResist = target:getMod(xi.mod.BLINDRES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Base power
    -- Min cap: 15 at -80 dINT
    -- Max cap: 90 at 120 dINT
    local basePotency = utils.clamp(math.floor(dINT / 3 * 8 + 45), 15, 90)

    if (merits > 1) then
        basePotency = basePotency + merits - 1
    end
    
    local potency = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = merits * 2
    params.effect = xi.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(params.effect, potency, 0, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.BLINDRES, currentResist + 15)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end