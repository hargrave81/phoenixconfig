-----------------------------------
-- Area: North Sandoria
--  NPC: Survival Guide
-- Fast Rank
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player,npc,trade)
    
end

function onZoneIn(player,prevZone)
    player:setCharVar("SandyMissionFast",0);
end

function onTrigger(player,npc)
    if player:getCharVar("SandyMissionFast") == 1 then
        local logInfo = GetMissionLogInfo(0); -- get where they are currently
        local areaMissionIds = xi.mission.id[xi.mission.area[0]]
        local missionId = 0
        if (missionId ~= nil) then
            missionId = tonumber(missionId) or areaMissionIds[string.upper(missionId)] or _G[string.upper(missionId)];
        end
        if (missionId == nil or missionId < 0) then
            error(player, "Invalid missionID.");
            return;
        end
        local i = missionId
        while i < 14 do
            if i ~= missionId then player:addMission(0, i) end
            player:PrintToPlayer("Complete mission #"..i)
            player:completeMission(0, i)
            i = i + 1
        end
        player:setRank(5);
        if not player:hasKeyItem(xi.keyItem.AIRSHIP_PASS) then
            player:addKeyItem(xi.keyItem.AIRSHIP_PASS)
        end
        if not player:hasKeyItem(xi.keyItem.SILVER_BELL) then
            player:addKeyItem(xi.keyItem.SILVER_BELL)
        end
        if not player:hasKeyItem(xi.keyItem.CORUSCANT_ROSARY) then
            player:addKeyItem(xi.keyItem.CORUSCANT_ROSARY)
        end
        if not player:hasKeyItem(xi.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(xi.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(xi.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(xi.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(xi.keyItem.YAGUDO_TORCH) then
            player:addKeyItem(xi.keyItem.YAGUDO_TORCH)
        end
        if not player:hasKeyItem(xi.keyItem.CREST_OF_DAVOI_KI) then
            player:addKeyItem(xi.keyItem.CREST_OF_DAVOI_KI)
        end
        if not player:hasKeyItem(xi.keyItem.DELKFUTT_KEY) then
            player:addKeyItem(xi.keyItem.DELKFUTT_KEY)
        end
        if not player:hasKeyItem(xi.keyItem.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(xi.keyItem.ARCHDUCAL_AUDIENCE_PERMIT)
        end  
        if not player:hasKeyItem(xi.keyItem.MESSAGE_TO_JEUNO_SANDORIA) then
            player:addKeyItem(xi.keyItem.MESSAGE_TO_JEUNO_SANDORIA)
        end
        player:addMission(0, 14)
        player:setCharVar("SandyMissionFast",0)        
    else
        if player:getNation() == 0 and player:getRank() < 5 and player:getMainLvl() >= 30 then
            player:PrintToPlayer("Talk to me one more time and I'll auto rank you up!")
            player:setCharVar("SandyMissionFast",1)
        elseif player:getMainLvl() < 30 then
            player:PrintToPlayer("Go get some more experience first bub!")
        else
            player:PrintToPlayer("You are already so epic or you belong to another nation!")        
        end        
    end
end

function onEventFinish(player,csid,option)
    
end


--        ["SANDORIA"] =  0,
--        ["BASTOK"]   =  1,
--        ["WINDURST"] =  2