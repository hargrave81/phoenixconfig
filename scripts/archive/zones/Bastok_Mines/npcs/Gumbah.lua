-----------------------------------
-- Area: Bastok Mines
--  NPC: Gumbah
-- Finishes Quest: Blade of Darkness, Inheritance
-- !pos 52 0 -36 234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

local wsQuest = xi.wsquest.ground_strike

function onTrade(player,npc,trade)
    local wsQuestEvent = xi.wsquest.getTradeEvent(wsQuest,player,trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player,npc)
    local wsQuestEvent = xi.wsquest.getTriggerEvent(wsQuest,player)
    local bladeDarkness = player:getQuestStatus(BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (player:getMainLvl() >= ADVANCED_JOB_LEVEL and  bladeDarkness == QUEST_AVAILABLE) then
        --DARK KNIGHT QUEST
        player:startEvent(99)
    elseif (bladeDarkness == QUEST_COMPLETED and player:getQuestStatus(BASTOK,xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_AVAILABLE) then
        player:startEvent(130)
    elseif ((player:hasCompletedMission(BASTOK, xi.mission.id.bastok.ON_MY_WAY) == true)
    or ((player:getCurrentMission(BASTOK) == xi.mission.id.bastok.ON_MY_WAY) and (player:getCharVar("MissionStatus") == 3)))
        and (player:getCharVar("[B7-2]Werei") == 0) then
        player:startEvent(177)
    else
        --DEFAULT
        player:startEvent(52)
    end
end

function onEventFinish(player,csid,option)
    if (csid == 99) then
        player:addQuest(BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS)   
        player:setCharVar("ChaosbringerKills",100)
        npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS, {title=xi.title.DARK_SIDER, var="ZeruhnMines_Zeid_CS"})
        player:addItem(16607)        
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16607)
        player:unlockJob(xi.job.DRK)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DARK_KNIGHT)
    elseif (csid == 130) then
        player:addQuest(BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH)
        player:addKeyItem(xi.ki.LETTER_FROM_ZEID)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,xi.ki.LETTER_FROM_ZEID)
    elseif (csid == 177) then
        player:setCharVar("[B7-2]Werei", 1)
    else
        xi.wsquest.handleEventFinish(wsQuest,player,csid,option,ID.text.GROUND_STRIKE_LEARNED)
    end
end