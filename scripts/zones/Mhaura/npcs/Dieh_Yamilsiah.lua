-----------------------------------
-- Area: Mhaura
--  NPC: Dieh Yamilsiah
-- Reports the time remaining before boat arrival.
-- !pos 7.057 -2.364 2.489 249
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    -- Each boat comes every 1152 seconds/8 game hours, 4 hour offset between Selbina and Aht Urghan
    -- Original timer: local timer = 1152 - ((os.time() - 1009810584)%1152);
    local timer = 1152 - ((os.time() - 1009810802)%1152);
    local destination = 0; -- Selbina, set to 1 for Al Zhabi
    local direction = 0; -- Arrive, 1 for depart
    local waiting = 216; -- Offset for Selbina

    -- Next ferry is Al Zhabi for higher values.
    if (timer >= 576) then
        destination = 1;
        timer = timer - 576;
        waiting = 193;
    end

    if player:getCharVar("MhauraFastShip") == 1 then        
        player:setCharVar("MhauraFastShip",0)
        if destination == 0 then
            player:setPos(18.9472, -1.78, -48.3702, 45, 248)  -- Selbina
        else
            player:setPos(-11.39, 0, -118.701, 0, 50) -- {R} Aht Urhgan Whitegate Chamber of Passage Left
        end        
        return
    end

    -- Logic to manipulate cutscene results.
    if (timer <= waiting) then
        direction = 1; -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting; -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    if destination == 0 then
        player:PrintToPlayer("Talk to me again to be warped to the next destination (currently Selbina).")
    else
        player:PrintToPlayer("Talk to me again to be warped to the next destination (currently Aht Urghan).")
    end
    player:setCharVar("MhauraFastShip",1)
    player:startEvent(231,timer,direction,0,destination); -- timer arriving/departing ??? destination

    --[[Other cutscenes:
    233 "This ship is headed for Selbina."
    234 "The Selbina ferry will deparrrt soon!  Passengers are to board the ship immediately!"

    Can't find a way to toggle the destination on 233 or 234, so they are not used.
    Users knowing which ferry is which > using all CSs.]]

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;