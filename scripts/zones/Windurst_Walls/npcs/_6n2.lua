-----------------------------------
-- Area: Windurst Walls
-- Door: House of the Hero
-- Involved in Mission 2-1
-- Involved In Quest: Know One's Onions, Onion Rings, The Puppet Master, Class Reunion
-- !pos -26 -13 260 239
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/quests");
require("scripts/globals/status");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local ThePuppetMaster = player:getQuestStatus(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER);
    local ClassReunion = player:getQuestStatus(WINDURST,dsp.quest.id.windurst.CLASS_REUNION);
    local CarbuncleDebacle = player:getQuestStatus(WINDURST,dsp.quest.id.windurst.CARBUNCLE_DEBACLE);
    -- Check for Missions first (priority?)
    if (player:getCurrentMission(WINDURST) == dsp.mission.id.windurst.LOST_FOR_WORDS and player:getVar("MissionStatus") == 5) then
        player:startEvent(337);
    else
        ----------------------------------------------------
        -- SMN unlock quest
        if (player:getQuestStatus(WINDURST,dsp.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_AVAILABLE and player:getMainLvl() >= ADVANCED_JOB_LEVEL and player:hasItem(1125)) then
            player:startEvent(384,1125,1125,1125,1125,1125,1125,1125,1125);
        elseif (player:getQuestStatus(WINDURST,dsp.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED) then
            player:startEvent(385,1125,1125,1125,1125,1125,1125,1125,1125);
        ----------------------------------------------------
        -- The Puppet Master (AF weapon)
        elseif (player:getMainLvl() >= AF1_QUEST_LEVEL and player:getMainJob() == dsp.job.SMN and ThePuppetMaster == QUEST_AVAILABLE and player:needToZone() == false and ClassReunion ~= QUEST_ACCEPTED and CarbuncleDebacle ~= QUEST_ACCEPTED) then -- you need to be on SMN as well to repeat the quest
            player:startEvent(402); -- Carby asks for your help, visit Juroro
        elseif (player:getQuestStatus(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER) == QUEST_ACCEPTED and player:getVar("ThePuppetMasterProgress") == 1) then
            player:startEvent(403); -- reminder to visit Juroro
        ----------------------------------------------------
        -- Class Reunion (AF pants)
        elseif (player:getMainLvl() >= AF2_QUEST_LEVEL and player:getMainJob() == dsp.job.SMN and ThePuppetMaster == QUEST_COMPLETED and ClassReunion == QUEST_AVAILABLE and player:needToZone() == false) then
            player:startEvent(413); -- Carby asks for your help again.
        ----------------------------------------------------
        -- Carbuncle Debacle (AF head)
        elseif (player:getMainLvl() >= AF3_QUEST_LEVEL and player:getMainJob() == dsp.job.SMN and ClassReunion == QUEST_COMPLETED and CarbuncleDebacle == QUEST_AVAILABLE and player:needToZone() == false) then
            player:startEvent(415); -- Carby begs for your help
        ----------------------------------------------------
        elseif (player:hasKeyItem(dsp.ki.JOKER_CARD)) then
            player:startEvent(387,0,dsp.ki.JOKER_CARD);
        elseif (player:getVar("WildCard") == 1) then
            player:startEvent(386);
        elseif (player:getVar("OnionRings") == 1) then
            player:startEvent(289);
        elseif (player:getVar("KnowOnesOnions") == 1) then
            player:startEvent(288,0,4387);
        else
            player:messageSpecial(ID.text.DOORS_SEALED_SHUT); -- "The doors are firmly sealed shut."
        end;
    end;

    return 1;
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID2: %u",csid);
    -- printf("RESULT2: %u",option);
end;

function onEventFinish(player,csid,option)

    if (csid == 288) then
        player:setVar("KnowOnesOnions",2);
    elseif (csid == 289) then
        player:completeQuest(WINDURST,dsp.quest.id.windurst.ONION_RINGS);
        player:addFame(WINDURST,100);
        player:addTitle(dsp.title.STAR_ONION_BRIGADIER);
        player:delKeyItem(dsp.ki.OLD_RING);
        player:setVar("OnionRingsTime",0);
        player:setVar("OnionRings",2);
    elseif (csid == 384) then
        player:addQuest(WINDURST, dsp.quest.id.windurst.I_CAN_HEAR_A_RAINBOW);
        player:setVar( "I_CAN_HEAR_A_RAINBOW",128);        
        player:completeQuest(WINDURST, dsp.quest.id.windurst.I_CAN_HEAR_A_RAINBOW);
        player:addTitle(dsp.title.RAINBOW_WEAVER);
        player:unlockJob(dsp.job.SMN);
        player:addSpell(296);
        player:addSpell(291);
        player:messageSpecial(ID.text.UNLOCK_SUMMONER);
        player:messageSpecial(ID.text.UNLOCK_CARBUNCLE);        
        player:setVar("ICanHearARainbow",0);
        SetServerVariable("I_Can_Hear_a_Rainbow", 1);
    elseif (csid == 386) then
        player:setVar("WildCard",2);
    elseif (csid == 387) then
        player:delKeyItem(dsp.ki.JOKER_CARD);
        player:addGil(GIL_RATE*8000);
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*8000);
    elseif (csid == 337) then
        -- Mark the progress
        player:setVar("MissionStatus",6);
    elseif (csid == 402) then
        if (player:getQuestStatus(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER) == QUEST_COMPLETED) then
            player:delQuest(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER);
            player:addQuest(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER); -- this needs only if you repeat this quest
        end;
        player:setVar("ThePuppetMasterProgress",1);
        player:addQuest(WINDURST,dsp.quest.id.windurst.THE_PUPPET_MASTER);
    elseif (csid == 413) then
        player:setVar("ClassReunionProgress",1);
        player:addQuest(WINDURST,dsp.quest.id.windurst.CLASS_REUNION);
        player:addKeyItem(dsp.ki.CARBUNCLES_TEAR);
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,dsp.ki.CARBUNCLES_TEAR);
    elseif (csid == 415) then
        player:addQuest(WINDURST,dsp.quest.id.windurst.CARBUNCLE_DEBACLE);
        player:setVar("CarbuncleDebacleProgress",1);
    end;

end;