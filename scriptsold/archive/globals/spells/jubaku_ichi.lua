-----------------------------------------
-- Spell: Jubaku: Ichi
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and INT.
-- taken from paralyze
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local effect = xi.effect.PARALYSIS

    local currentResist = target:getMod(xi.mod.PARALYZERES)
    if currentResist == nil then
        currentResist = 0
    end

    -- Base Stats
    local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    --Duration Calculation
    local duration = 180
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.NINJUTSU
    params.bonus = 0
    duration = duration * applyResistance(caster, target, spell, params)
    --Paralyze base power is 20 and is not affected by resistaces.
    local power = 20

    --Calculates resist chanve from Reist Blind
    if (math.random(0,100) >= target:getMod(xi.mod.PARALYZERES)) then
        if (duration >= 80) then
            -- Erases a weaker blind and applies the stronger one
            local paralysis = target:getStatusEffect(effect)
            if (paralysis ~= nil) then
                if (paralysis:getPower() < power) then
                    target:delStatusEffect(effect)
                    target:addStatusEffect(effect,power,0,duration)
                    spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
                    target:setMod(xi.mod.PARALYZERES, currentResist + 5)
                else
                    -- no effect
                    spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
                end
            else
                target:addStatusEffect(effect,power,0,duration)
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
                target:setMod(xi.mod.PARALYZERES, currentResist + 5)
            end
        else
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST_2)
    end
    return effect
end
