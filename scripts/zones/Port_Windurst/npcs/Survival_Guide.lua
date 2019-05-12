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
        if not player:hasKeyItem(dsp.keyItem.AIRSHIP_PASS) then
            player:addKeyItem(dsp.keyItem.AIRSHIP_PASS)
        end
        if not player:hasKeyItem(dsp.keyItem.STARWAY_STAIRWAY_BAUBLE) then
            player:addKeyItem(dsp.keyItem.STARWAY_STAIRWAY_BAUBLE)
        end
        if not player:hasKeyItem(dsp.keyItem.SILVER_BELL) then
            player:addKeyItem(dsp.keyItem.SILVER_BELL)
        end
        if not player:hasKeyItem(dsp.keyItem.CORUSCANT_ROSARY) then
            player:addKeyItem(dsp.keyItem.CORUSCANT_ROSARY)
        end
        if not player:hasKeyItem(dsp.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(dsp.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(dsp.keyItem.BLACK_MATINEE_NECKLACE) then
            player:addKeyItem(dsp.keyItem.BLACK_MATINEE_NECKLACE)
        end
        if not player:hasKeyItem(dsp.keyItem.YAGUDO_TORCH) then
            player:addKeyItem(dsp.keyItem.YAGUDO_TORCH)
        end
        if not player:hasKeyItem(dsp.keyItem.CREST_OF_DAVOI_KI) then
            player:addKeyItem(dsp.keyItem.CREST_OF_DAVOI_KI)
        end
        if not player:hasKeyItem(dsp.keyItem.DELKFUTT_KEY) then
            player:addKeyItem(dsp.keyItem.DELKFUTT_KEY)
        end
        if not player:hasKeyItem(dsp.keyItem.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(dsp.keyItem.ARCHDUCAL_AUDIENCE_PERMIT)
        end        
        if not player:hasKeyItem(dsp.keyItem.MESSAGE_TO_JEUNO_WINDURST) then
            player:addKeyItem(dsp.keyItem.MESSAGE_TO_JEUNO_WINDURST)
        end
        player:addMission(2, 14)
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