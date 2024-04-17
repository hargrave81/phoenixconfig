-----------------------------------------
-- Spell: Stun
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local duration = 5

    local currentResist = target:getMod(xi.mod.STUNRES)
    if currentResist == nil then
        currentResist = 0
    end


    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = 37
    params.bonus = 0
    params.effect = xi.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist <= (1/16)) then
        -- resisted!
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return 0
    end

    if (target:hasStatusEffect(xi.effect.STUN)) then
        -- no effect
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        if (target:addStatusEffect(xi.effect.STUN,1,0,duration*resist)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            target:setMod(xi.mod.STUNRES, currentResist + 10)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.STUN
end
