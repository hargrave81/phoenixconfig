-----------------------------------------
-- Spell: Silence
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local effectType = xi.effect.SILENCE


    local currentResist = target:getMod(xi.mod.SILENCERES)
    if currentResist == nil then
        currentResist = 0
    end


    if (target:hasStatusEffect(effectType)) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return effectType
    end

    --Pull base stats.
    local dMND = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))

    --Duration, including resistance.  May need more research.
    local duration = 120

    --Resist
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.MND
    params.skillType = 35
    params.bonus = 0
    params.effect = xi.effect.SILENCE
    local resist = applyResistanceEffect(caster, target, spell, params)

    if (resist >= 0.5) then --Do it!
        if (target:addStatusEffect(effectType,1,0,duration * resist)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.SILENCERES, currentResist + 15)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effectType

end
