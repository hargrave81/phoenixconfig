-----------------------------------------
-- Spell: Refueling
-- Increases attack speed
-- Spell cost: 29 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI+2
-- Level: 48
-- Casting Time: 1.5 seconds
-- Recast Time: 30 seconds
-- Duration: 5 minutes
--
-- Combos: None
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffect = xi.effect.HASTE
    local power = 3000 -- 10%
    local duration = 400

    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration / 100)* diffMerit
        end;

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if not target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end
