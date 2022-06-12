-----------------------------------------
-- Spell: Hojo:Ichi
-- Description: Inflicts Slow on target.
-- Edited from slow.lua
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    
    local currentResist = target:getMod(xi.mod.SLOWRES)
    if currentResist == nil then
        currentResist = 0
    end

    --Power for Hojo is a flat 14.6% reduction
    local power = 1500
    --Duration and Resistance calculation
    local duration = 180
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.NINJUTSU
    params.bonus = 0
    duration = duration * applyResistance(caster, target, spell, params)
    --Calculates the resist chance from Resist Blind trait
    if math.random(0,100) >= target:getMod(xi.mod.SLOWRES) then
        -- Spell succeeds if a 1 or 1/2 resist check is achieved
        if duration >= 150 then
            if target:addStatusEffect(xi.effect.SLOW, power, 0, duration) then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
                target:setMod(xi.mod.SLOWRES, currentResist + 4)
            else
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            end

        else
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST_2)
    end

    return xi.effect.SLOW
end
