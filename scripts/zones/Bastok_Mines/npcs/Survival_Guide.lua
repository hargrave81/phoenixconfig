-----------------------------------
-- Area: Bastok Mines
--  NPC: Survival Guide
-- Fast Rank
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player,npc,trade)
    
end

function onZoneIn(player,prevZone)
    player:setCharVar("BastokMissionFast",0);
end

function onTrigger(player,npc)
    if player:getCharVar("BastokMissionFast") == 1 then
        local logInfo = GetMissionLogInfo(1); -- get where they are currently
        local areaMissionIds = tpz.mission.id[tpz.mission.area[1]]
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
            if i ~= missionId then player:addMission(1, i) end
            player:PrintToPlayer("Complete mission #"..i)
            player:completeMission(1, i)
            i = i + 1
        end
        player:setRank(5);
        if not player:hasKeyItem(tpz.keyItem.AIRSHIP_PASS) then
            player:addKeyItem(tpz.keyItem.AIRSHIP_PASS)
        end
        if not player:hasKeyItem(tpz.keyItem.SILVER_BELL) then
            player:addKeyItem(tpz.keyItem.SILVER_BELL)
        end
        if not player:hasKeyItem(tpz.keyItem.CORUSCANT_ROSARY) then
            player:addKeyItem(tpz.keyItem.CORUSCANT_ROSARY)
        end
        if not player:hasKeyItem(tpz.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(tpz.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(tpz.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(tpz.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(tpz.keyItem.YAGUDO_TORCH) then
            player:addKeyItem(tpz.keyItem.YAGUDO_TORCH)
        end
        if not player:hasKeyItem(tpz.keyItem.CREST_OF_DAVOI_KI) then
            player:addKeyItem(tpz.keyItem.CREST_OF_DAVOI_KI)
        end
        if not player:hasKeyItem(tpz.keyItem.DELKFUTT_KEY) then
            player:addKeyItem(tpz.keyItem.DELKFUTT_KEY)
        end
        if not player:hasKeyItem(tpz.keyItem.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(tpz.keyItem.ARCHDUCAL_AUDIENCE_PERMIT)
        end
        if not player:hasKeyItem(tpz.keyItem.MESSAGE_TO_JEUNO_BASTOK) then
            player:addKeyItem(tpz.keyItem.MESSAGE_TO_JEUNO_BASTOK)
        end
        player:addMission(1, 14)
        player:setCharVar("BastokMissionFast",0)        
    else
        if player:getNation() == 1 and player:getRank() < 5 and  player:getMainLvl() >= 30  then
            player:PrintToPlayer("Talk to me one more time and I'll auto rank you up!")
            player:setCharVar("BastokMissionFast",1)
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