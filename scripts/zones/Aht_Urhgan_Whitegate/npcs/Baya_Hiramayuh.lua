-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Baya Hiramayuh
-- Standard Info NPC
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    -- Based on scripts/zones/Mhaura/Dieh_Yamilsiah.lua
    local timer = 1152 - ((os.time() - 1009811376)%1152)
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 195 -- Offset for Mhaura

    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    if player:getVar("AhtUrhganFastShip") == 1 then        
        player:setVar("AhtUrhganFastShip",0)
        player:setPos(8.3066, -3.4298, 17.0278, 0, 249)        -- Mhaura
        return
    end

    player:PrintToPlayer("Talk to me again to be warped to the next destination.")
    player:setVar("AhtUrhganFastShip",1)
    player:startEvent(232,timer,direction)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end