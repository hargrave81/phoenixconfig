-----------------------------------
-- Area: Promyvion Holla
-----------------------------------

require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onTrigger(player, npc)
    if player:hasStatusEffect(tpz.effect.REFRESH) == false and player:hasStatusEffect(tpz.effect.ATTACK_BOOST) == false then
        player:PrintToPlayer("Boosting you up Kupo!")
        if player:hasStatusEffect(tpz.effect.DEDICATION) == false then
            player:addStatusEffect(tpz.effect.DEDICATION,100,0,9600,0,90000)
        end
        player:addStatusEffect(tpz.effect.REGEN, 2, 3, 1200)
        player:addStatusEffect(tpz.effect.REFRESH, 1, 3, 1200, 0, 3)    
        player:addStatusEffect(tpz.effect.ATTACK_BOOST, 34, 0, 1200)
        player:addStatusEffect(tpz.effect.EVASION_BOOST, 10, 0, 1200)
        player:addStatusEffect(tpz.effect.ACCURACY_BOOST, 15, 0, 1200)
        player:addStatusEffect(tpz.effect.DEX_BOOST, 5, 0, 1200)
        player:addStatusEffect(tpz.effect.STR_BOOST, 5, 0, 1200)
        
        player:addStatusEffect(tpz.effect.DEFENSE_BOOST, 40, 0, 1200)


        if player:hasStatusEffect(tpz.effect.PROTECT) == false then
            player:addStatusEffect(tpz.effect.PROTECT, 30, 0, 1200)
        end
        if player:hasStatusEffect(tpz.effect.SHELL) == false then
            player:addStatusEffect(tpz.effect.SHELL, 30, 0, 1200)
        end
        if player:hasStatusEffect(tpz.effect.WEAKNESS) == false then
            player:delStatusEffect(tpz.effect.WEAKNESS)
        end
        if player:getMainLvl() <= 30 then
            player:addStatusEffect(tpz.effect.RERAISE, 1, 0, 1200)
        end    
    else
        player:PrintToPlayer("Come back when you need more buffs KU-PHEH!")
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end