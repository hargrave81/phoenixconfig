-----------------------------------------
-- Spell: Diamondhide
-- Gives party members within area of effect the effect of "Stoneskin"
-- Spell cost: 99 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1
-- Level: 67
-- Casting Time: 7 seconds
-- Recast Time: 1 minute 30 seconds
-- 5 minutes
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
    local typeEffect = xi.effect.STONESKIN
    local blueskill = caster:getSkillLevel(xi.skill.BLUE_MAGIC)
    local power = ((blueskill)/3) *2.3
    local duration = 400

    if not target:addStatusEffect(typeEffect,power,0,duration,0,0,2) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end
