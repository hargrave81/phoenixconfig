-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    -- Duration, including resistance.  May need more research.
    local duration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local currentResist = target:getMod(xi.mod.BINDRES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Resist
    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        --Try to erase a weaker bind.
        if target:addStatusEffect(params.effect, target:speed(), 0 , duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.BINDRES, currentResist + 10)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
