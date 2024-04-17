-----------------------------------------
-- Spell: Cocoon
-- Enhances defense
-- Spell cost: 10 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: VIT+3
-- Level: 8
-- Casting Time: 1.75 seconds
-- Recast Time: 60 seconds
-- Duration: 90 seconds
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power = 65 -- Percentage, not amount.
    local duration = 130

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect,power,0,duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        if caster:getMod(xi.mod.MAGIC_SKILLUP_RATE) < 30 then
            caster:addMod(xi.mod.MAGIC_SKILLUP_RATE, 30)
        end
    end

    return typeEffect
end
