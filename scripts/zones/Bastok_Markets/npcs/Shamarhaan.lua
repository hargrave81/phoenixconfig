-----------------------------------
-- Area: Bastok Markets
--  NPC: Shamarhaan
-- Type: Quest Starter
-- Involved in quest: No Strings Attached
-- !pos -285.382 -13.021 -84.743 235
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/quests");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local NoStringsAttached = player:getQuestStatus(AHT_URHGAN,dsp.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED);
    local NoStringsAttachedProgress = player:getVar("NoStringsAttachedProgress");

    if (player:getMainLvl() >= ADVANCED_JOB_LEVEL and NoStringsAttached == QUEST_AVAILABLE) then
        player:startEvent(434); -- initial cs to start the quest, go and see Iruki-Waraki at Whitegate
    elseif (NoStringsAttachedProgress == 1) then
        player:startEvent(435); -- reminder to go see Iruki-Waraki at Whitegate
    else
        player:startEvent(433);
    end;
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 434) then        
        player:addQuest(AHT_URHGAN,dsp.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED);
        player:setVar("NoStringsAttachedProgress",6)
        player:setVar("CreationStarted_Day",0)
        player:setVar("CreationStarted_Year",0)
        npcUtil.completeQuest(player, AHT_URHGAN,dsp.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED, {item=17859, title=dsp.title.PROUD_AUTOMATON_OWNER, var="NoStringsAttachedProgress"})
        player:unlockJob(dsp.job.PUP)
        player:messageSpecial(ID.text.YOU_CAN_BECOME_PUP) -- "You can now become a puppetmaster."
        player:setPetName(dsp.pet.type.AUTOMATON, option+118)
        player:unlockAttachment(8224) --Harlequin Frame
        player:unlockAttachment(8193) --Harlequin Head
    end;
end;
