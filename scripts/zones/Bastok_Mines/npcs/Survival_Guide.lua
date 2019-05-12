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
    player:setVar("BastokMissionFast",0);
end

function onTrigger(player,npc)
    if player:getVar("BastokMissionFast") == 1 then
        local logInfo = GetMissionLogInfo(1); -- get where they are currently
        local areaMissionIds = dsp.mission.id[dsp.mission.area[1]]
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
        player:setVar("BastokMissionFast",0)        
    else
        if player:getNation() == 1 and player:getRank() < 5 then
            player:PrintToPlayer("Talk to me one more time and I'll auto rank you up!")
            player:setVar("BastokMissionFast",1)
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