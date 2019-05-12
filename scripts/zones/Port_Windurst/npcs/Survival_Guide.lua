-----------------------------------
-- Area: Port Windurst
--  NPC: Survival Guide
-- Fast Rank
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

function onTrade(player,npc,trade)
    
end

function onZoneIn(player,prevZone)
    player:setVar("WindyMissionFast",0);
end

function onTrigger(player,npc)
    if player:getVar("WindyMissionFast") == 1 then
        local logInfo = GetMissionLogInfo(2); -- get where they are currently
        local areaMissionIds = dsp.mission.id[dsp.mission.area[2]]
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
            if i ~= missionId then player:addMission(2, i) end
            player:PrintToPlayer("Complete mission #"..i)
            player:completeMission(2, i)
            i = i + 1
        end
        player:setRank(5);
        player:setVar("WindyMissionFast",0)        
    else
        if player:getNation() == 2 and player:getRank() < 5 then
            player:PrintToPlayer("Talk to me one more time and I'll auto rank you up!")
            player:setVar("WindyMissionFast",1)
        else
            player:PrintToPlayer("You are already so epic!")
        end        
    end
end

function onEventFinish(player,csid,option)
    
end


--        ["SANDORIA"] =  0,
--        ["BASTOK"]   =  1,
--        ["WINDURST"] =  2