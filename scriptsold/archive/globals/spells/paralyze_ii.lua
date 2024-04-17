-----------------------------------------
-- Spell: Paralyze II
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-- caster:getMerit() returns a value which is equal to the number of merit points TIMES the value of each point
-- Paralyze II value per point is '1' This is a constant set in the table 'merits'
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
    local merits = caster:getMerit(xi.merit.PARALYZE_II)

    local currentResist = target:getMod(xi.mod.PARALYZERES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Pull base stats
    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    -- Base potency
    local potency = utils.clamp(math.floor(dMND / 4) + 20, 10, 30)

    if (merits > 1) then
        potency = potency + merits - 1
    end
    
    potency = calculatePotency(potency, spell:getSkillType(), caster, target)

    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local params = {}
    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = merits * 2
    params.effect = xi.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then
        if target:addStatusEffect(params.effect, potency, 0, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.PARALYZERES, currentResist + 12)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end