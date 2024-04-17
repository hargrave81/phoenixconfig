-----------------------------------------
-- Spell: Horde Lullaby II
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)

    local currentResist = target:getMod(xi.mod.SLEEPRES)
    if currentResist == nil then
        currentResist = 0
    end

    local duration = 30
    local pCHR = caster:getStat(xi.mod.CHR)
    local mCHR = target:getStat(xi.mod.CHR)
    local dCHR = pCHR - mCHR
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = 0
    params.effect = xi.effect.LULLABY
    resm = applyResistanceEffect(caster, target, spell, params)

    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(xi.mod.LULLABY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

        duration = duration * (iBoost * 0.1 + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100 + 1)

        if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
            duration = duration * 2
        end

        if target:addStatusEffect(xi.effect.LULLABY, 1, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            target:setMod(xi.mod.SLEEPRES, currentResist + 15)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.LULLABY
end
