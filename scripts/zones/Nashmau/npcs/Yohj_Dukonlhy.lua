-----------------------------------
-- Area: Nashmau
--  NPC: Yohj Dukonlhy
-- Standard Info NPC
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    -- Based on scripts/zones/Mhaura/Dieh_Yamilsiah.lua
    local timer = 1152 - ((os.time() - 1009810800)%1152);
    local direction = 0; -- Arrive, 1 for depart
    local waiting = 431; -- Offset for Nashmau

    if (timer <= waiting) then
        direction = 1; -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting; -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    if player:getCharVar("AlZahbiFastShip") == 1 then        
        player:setCharVar("AlZahbiFastShip",0)
        player:setPos(12.0933, 0, 120.6054, 0, 50)        -- Aht Urhgan
        return
    end

    player:PrintToPlayer("Talk to me again to be warped to the next destination.")
    player:setCharVar("AlZahbiFastShip",1)

    player:startEvent(231,timer,direction);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;