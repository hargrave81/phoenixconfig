-----------------------------------------
-- Spell: Sleep
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = caster:getStat(dsp.mod.INT) - target:getStat(dsp.mod.INT)

    local duration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    
    local currentResist = target:getMobMod(dsp.mobMod.BUILD_RESIST)
    if currentResist == nil then
        currentResist = 0
    end

    local params = {}
    params.diff = dINT - currentResist * 2
    params.skillType = dsp.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = dsp.effect.SLEEP_I

    local resist = applyResistanceEffect(caster, target, spell, params)

    caster:PrintToPlayer("dINT -> "..dINT.." resist ->"..currentResist.." calc =>"..resist)
    
    if resist >= 0.5 then
        if target:addStatusEffect(params.effect, 1, 0, duration * resist) then
            spell:setMsg(dsp.msg.basic.MAGIC_ENFEEB_IS)            
            target:setMobMod(dsp.mobMod.BUILD_RESIST, currentResist + 1)
        else
            spell:setMsg(dsp.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(dsp.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end