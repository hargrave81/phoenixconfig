-----------------------------------
-- Area: Selbina
--  NPC: Humilitie
-- Reports the time remaining before boat arrival.
-- !pos 17.979 -2.39 -58.800 248
-----------------------------------
require("scripts/globals/teleports");

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    -- Based on scripts/zones/Mhaura/Dieh_Yamilsiah.lua
    if player:getCharVar("SelbinaFastShip") == 1 then
        player:setCharVar("SelbinaFastShip",0)
        player:setPos(8.3066, -3.4298, 17.0278, 0, 249)        -- Mhaura
        return
    end
    local timer = 1152 - ((os.time() - 1009810800) % 1152)
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 216 -- Offset for Mhaura

    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end
    player:PrintToPlayer("Talk to me again to be warped to the destination.")
    player:setCharVar("SelbinaFastShip",1)
    player:startEvent(231, timer, direction)    
end

function onEventUpdate(player,csid,option)

end

function onEventFinish(player,csid,option)
end