-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Waoud
-- Standard Info NPC
-- Involved in quests: An Empty Vessel (BLU flag), Beginnings (BLU AF1)
-- !pos 65 -6 -78 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player,npc,trade)
    local anEmptyVessel = player:getQuestStatus(AHT_URHGAN,xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
    local anEmptyVesselProgress = player:getCharVar("AnEmptyVesselProgress")
    local StoneID = player:getCharVar("EmptyVesselStone")

    -- AN EMPTY VESSEL (dangruf stone, valkurm sunsand, or siren's tear)
    if anEmptyVessel == QUEST_ACCEPTED and anEmptyVesselProgress == 3 and trade:hasItemQty(StoneID,1) and trade:getItemCount() == 1 then
        player:startEvent(67,StoneID) -- get the stone to Aydeewa
    end
end

function onTrigger(player,npc)
    local anEmptyVessel = player:getQuestStatus(AHT_URHGAN,xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
    local anEmptyVesselProgress = player:getCharVar("AnEmptyVesselProgress")
    local divinationReady = true -- vanaDay() > player:getCharVar("LastDivinationDay")
    local beginnings = player:getQuestStatus(AHT_URHGAN,xi.quest.id.ahtUrhgan.BEGINNINGS)

    -- AN EMPTY VESSEL
    if ENABLE_TOAU == 1 and anEmptyVessel == QUEST_AVAILABLE and anEmptyVesselProgress <= 1 and player:getMainLvl() >= ADVANCED_JOB_LEVEL then
        if divinationReady then
            player:setCharVar("SuccessfullyAnswered",0)
            player:startEvent(60,player:getGil()) -- you must answer these 10 questions
        else
            player:startEvent(63) -- you failed, and must wait a gameday to try again
        end
    elseif anEmptyVesselProgress == 2 then
        if divinationReady and not player:needToZone() then
            player:startEvent(65) -- gives you a clue about the stone he wants (specific conditions)
        else -- Have not zoned, or have not waited, or both.
            player:startEvent(64) -- you have succeeded, but you need to wait a gameday and zone
        end
    elseif anEmptyVesselProgress == 3 then
        player:startEvent(66) -- reminds you about the item he wants
    elseif anEmptyVesselProgress == 4 then
        player:startEvent(68) -- reminds you to bring the item to Aydeewa
    elseif anEmptyVessel == QUEST_COMPLETED and beginnings == QUEST_AVAILABLE and player:getCharVar("BluAFBeginnings_Waoud") == 0 then
        player:startEvent(69) -- closing cutscene

    -- BEGINNINGS
    elseif anEmptyVessel == QUEST_COMPLETED and beginnings == QUEST_AVAILABLE and player:getCurrentMission(TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
            and player:getMainJob() == xi.job.BLU and player:getMainLvl() >= ADVANCED_JOB_LEVEL then
        if not divinationReady then
            player:startEvent(63)
        elseif player:needToZone() then
            player:startEvent(78,player:getGil()) -- dummy questions, costs you 1000 gil
        else
            player:startEvent(705,player:getGil()) -- start AF1 quest            
        end
    elseif beginnings == QUEST_ACCEPTED then
        local brand1 = player:hasKeyItem(xi.ki.BRAND_OF_THE_SPRINGSERPENT)
        local brand2 = player:hasKeyItem(xi.ki.BRAND_OF_THE_GALESERPENT)
        local brand3 = player:hasKeyItem(xi.ki.BRAND_OF_THE_FLAMESERPENT)
        local brand4 = player:hasKeyItem(xi.ki.BRAND_OF_THE_SKYSERPENT)
        local brand5 = player:hasKeyItem(xi.ki.BRAND_OF_THE_STONESERPENT)
        if brand1 and brand2 and brand3 and brand4 and brand5 then
            player:startEvent(707) -- reward immortal's scimitar
        else
            player:startEvent(706,player:getGil()) -- clue about the five staging points, costs you 1000 gil
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(61)
    end
end

function onEventUpdate(player,csid,option)
    -- AN EMPTY VESSEL
    if csid == 60 then
        local success = player:getCharVar("SuccessfullyAnswered")

        -- record correct answers
        if option < 40 then
            local correctAnswers = {2,6,9,12,13,18,21,24,26,30}
            for k,v in pairs(correctAnswers) do
                if (v == option) then
                    player:setCharVar("SuccessfullyAnswered", success + 1)
                    break
                end
            end
            success = 12
            player:setCharVar("SuccessfullyAnswered", success)
        -- determine results
        elseif option == 40 then
            if     success <  2 then player:updateEvent(player:getGil(),0,0,0,0,0,0,10) -- Springserpent
            elseif success <  4 then player:updateEvent(player:getGil(),0,0,0,0,0,0,20) -- Stoneserpent
            elseif success <  6 then player:updateEvent(player:getGil(),0,0,0,0,0,0,30) -- Galeserpent
            elseif success <  8 then player:updateEvent(player:getGil(),0,0,0,0,0,0,40) -- Flameserpent
            elseif success < 10 then player:updateEvent(player:getGil(),0,0,0,0,0,0,60) -- Skyserpent
            else
                local rand = math.random(1,3)
                switch (rand): caseof {
                    [1] = function (x) player:setCharVar("EmptyVesselStone",576) end, -- (576) Siren's Tear (576)
                    [2] = function (x) player:setCharVar("EmptyVesselStone",503) end, -- (502) Valkurm Sunsand (502)
                    [3] = function (x) player:setCharVar("EmptyVesselStone",553) end  -- (553) Dangruf Stone (553)
                }
                player:setCharVar("SuccessfullyAnswered", 0)
                player:updateEvent(player:getGil(),0,0,0,0,0,rand,70) -- all 5 serpents / success!
            end
        end
    elseif csid == 65 and option == 2 then
        player:setCharVar("AnEmptyVesselProgress",3)

    -- BEGINNINGS
    elseif csid == 78 and option == 40 then
        local serpent = math.random(1,5) * 10
        player:updateEvent(player:getGil(),0,0,0,0,0,0,serpent)

    end
end

function onEventFinish(player,csid,option)
    -- AN EMPTY VESSEL
    if csid == 60 then
        if option == 0 then
            player:setCharVar("AnEmptyVesselProgress", 1)
        elseif option == 50 then
            player:needToZone(false) -- remove this need
            player:setCharVar("LastDivinationDay",vanaDay())
            player:setCharVar("AnEmptyVesselProgress",2)
            player:addQuest(AHT_URHGAN,xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
        else
            player:setCharVar("LastDivinationDay",vanaDay())
            player:setCharVar("AnEmptyVesselProgress",1)
            player:delGil(1000)
            player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
        end
    elseif csid == 65 then -- skip the stones
        player:setCharVar("EmptyVesselStone",576)
        player:startEvent(67,576) -- get the stone to Aydeewa
    elseif csid == 67 then -- Turn in stone, go to Aydeewa
        player:setCharVar("AnEmptyVesselProgress",4)
        -- skip going to Aydeewa
        npcUtil.completeQuest(player, AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, {title=xi.title.BEARER_OF_THE_MARK_OF_ZAHAK, ki=xi.ki.MARK_OF_ZAHAK, var={"AnEmptyVesselProgress", "EmptyVesselStone"}})
        player:unlockJob(xi.job.BLU)  
        player:PrintToPlayer("You can now become a blue mage!")
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.AZOUPH)
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.DVUCCA)
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.MAMOOL)
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.HALVUNG)
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.ILRUSI)
        xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.NYZUL)
    elseif csid == 69 and option == 1 then
        player:needToZone(true)
        player:setCharVar("LastDivinationDay",vanaDay())
        player:setCharVar("BluAFBeginnings_Waoud",1)

    -- BEGINNINGS
    elseif csid == 78 and option == 1 then
        player:setCharVar("LastDivinationDay",vanaDay())
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 705 and option == 1 then
        player:addQuest(AHT_URHGAN,xi.quest.id.ahtUrhgan.BEGINNINGS)
    elseif csid == 706 and option == 1 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 707 then
        npcUtil.completeQuest(player, AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, {item=17717})
    end
end