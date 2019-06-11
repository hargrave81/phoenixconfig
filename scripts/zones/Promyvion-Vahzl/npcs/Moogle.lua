-----------------------------------
-- Area: Promyvion Vahzl
-----------------------------------

require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onTrigger(player, npc)
    if player:hasStatusEffect(dsp.effect.REFRESH) == false and player:hasStatusEffect(dsp.effect.ATTACK_BOOST) == false then
        player:PrintToPlayer("Boosting you up Kupo!")
        if player:hasStatusEffect(dsp.effect.DEDICATION) == false then
            player:addStatusEffect(dsp.effect.DEDICATION,100,0,9600,0,90000)
        end
        player:addStatusEffect(dsp.effect.REGEN, 3, 3, 1200)
        player:addStatusEffect(dsp.effect.REFRESH, 1, 3, 1200, 0, 3)    
        player:addStatusEffect(dsp.effect.ATTACK_BOOST, 42, 0, 1200)
        player:addStatusEffect(dsp.effect.EVASION_BOOST, 20, 0, 1200)
        player:addStatusEffect(dsp.effect.ACCURACY_BOOST, 25, 0, 1200)
        player:addStatusEffect(dsp.effect.ABYSSEA_DEX, 9, 0, 1200)
        player:addStatusEffect(dsp.effect.ABYSSEA_STR, 9, 0, 1200)
        if player:hasStatusEffect(dsp.effect.PROTECT) == false then
            player:addStatusEffect(dsp.effect.PROTECT, 70, 0, 1200)
        end
        if player:hasStatusEffect(dsp.effect.SHELL) == false then
            player:addStatusEffect(dsp.effect.SHELL, 70, 0, 1200)
        end
        if player:hasStatusEffect(dsp.effect.WEAKNESS) == false then
            player:delStatusEffect(dsp.effect.WEAKNESS)
        end
        if player:getMainLvl() <= 30 then
            player:addStatusEffect(dsp.effect.RERAISE, 1, 0, 1200)
        end    
    else
        player:PrintToPlayer("Come back when you need more buffs KU-PHEH!")
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end