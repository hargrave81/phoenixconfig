-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)

    --Pull base stats.
    local dINT = (caster:getStat(dsp.mod.INT) - target:getStat(dsp.mod.INT))

    --Duration, including resistance.  May need more research.
    local duration = 60

    local currentResist = target:getMod(dsp.mod.BINDRES)
    if currentResist == nil then
        currentResist = 0
    end

    --Resist
    local params = {}
    params.diff = nil
    params.attribute = dsp.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = dsp.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    if (resist >= 0.5) then --Do it!
        --Try to erase a weaker bind.
        if (target:addStatusEffect(dsp.effect.BIND,target:speed(),0,duration*resist)) then
            spell:setMsg(dsp.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(dsp.mod.BINDRES, currentResist + 10)
        else
            spell:setMsg(dsp.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(dsp.msg.basic.MAGIC_RESIST)
    end

    return dsp.effect.BIND

end
