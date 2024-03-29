-----------------------------------
--
-- Zone: RuLude_Gardens (243)
--
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1,-4,-2,40,4,3,50);
end;

function onZoneIn(player, prevZone)
    local cs = -1;
    -- MOG HOUSE EXIT
    player:setCharVar("ArtifactA",0)
    player:setCharVar("ArtifactB",0)
    player:setCharVar("ArtifactC",0)

    if player:getCurrentMission(COP) == xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG  and  player:getCharVar("PromathiaStatus") == 2 then
        cs = 10047
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        position = math.random(1, 5) + 45
        player:setPos(position, 10, -73, 192)
        if (player:getMainJob() ~= player:getCharVar("PlayerMainJob")) then
            cs = 30004;
        end
        player:setCharVar("PlayerMainJob",0);
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)

    local regionID = region:GetRegionID()
    -- printf("regionID: %u", regionID)

    if regionID == 1 then
        if player:getCurrentMission(COP) == xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN and player:getCharVar("PromathiaStatus") == 1 then
            player:startEvent(65, player:getNation())
        elseif player:getCurrentMission(COP) == xi.mission.id.cop.A_PLACE_TO_RETURN and player:getCharVar("PromathiaStatus") == 0 then
            player:startEvent(10048)
        elseif player:getCurrentMission(COP) == xi.mission.id.cop.FLAMES_IN_THE_DARKNESS and player:getCharVar("PromathiaStatus") == 2 then
            player:startEvent(10051)
        elseif player:getCurrentMission(TOAU) == xi.mission.id.toau.EASTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 1 then
            player:startEvent(10094)
        elseif player:getCurrentMission(TOAU) == xi.mission.id.toau.ALLIED_RUMBLINGS then
            player:startEvent(10097)
        elseif player:getCurrentMission(COP) == xi.mission.id.cop.DAWN then
            if player:getCharVar("COP_3-taru_story") == 2 and player:getCharVar("COP_shikarees_story") == 1 and player:getCharVar("COP_louverance_story") == 3
            and player:getCharVar("COP_tenzen_story") == 1 and player:getCharVar("COP_jabbos_story") == 1 then
                player:startEvent(122)
            elseif player:getCharVar("PromathiaStatus") == 7 then
                if player:getQuestStatus(JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_AVAILABLE then
                    player:startEvent(142)
                elseif player:getQuestStatus(JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 3 then
                    player:startEvent(143)
                end
            end
        end
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 65 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        player:addMission(COP, xi.mission.id.cop.THE_ROAD_FORKS) -- THE_ROAD_FORKS -- global mission 3.3
        -- We can't have more than 1 current mission at the time, so we keep The road forks as current mission
        -- progress are recorded in the following two variables
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 1) -- MEMORIES_OF_A_MAIDEN--3-3B: Windurst Road
        player:setCharVar("EMERALD_WATERS_Status", 1) -- EMERALD_WATERS-- 3-3A: San d'Oria Road
    elseif csid == 10047 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:addMission(COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
    elseif csid == 10048 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 10051 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 122 then
        player:setCharVar("PromathiaStatus", 4)
        player:setCharVar("COP_3-taru_story", 0)
        player:setCharVar("COP_shikarees_story", 0)
        player:setCharVar("COP_louverance_story", 0)
        player:setCharVar("COP_tenzen_story", 0)
        player:setCharVar("COP_jabbos_story", 0)
    elseif csid == 10094 then
        if option == 1 then
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2184)
            else
                player:completeMission(TOAU, xi.mission.id.toau.EASTERLY_WINDS)
                player:addMission(TOAU, xi.mission.id.toau.WESTERLY_WINDS)
                player:setCharVar("AhtUrganStatus", 0)
                player:addItem(2184, 10)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 2184)
            end
        else
            player:completeMission(TOAU, xi.mission.id.toau.EASTERLY_WINDS)
            player:addMission(TOAU, xi.mission.id.toau.WESTERLY_WINDS)
            player:setCharVar("AhtUrganStatus", 0)
        end
    elseif csid == 10097 then
        player:completeMission(TOAU, xi.mission.id.toau.ALLIED_RUMBLINGS)
        player:needToZone(true)
        player:setCharVar("TOAUM40_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, xi.mission.id.toau.UNRAVELING_REASON)
    elseif csid == 142 then
        player:addQuest(JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
    elseif csid == 143 then
        player:completeQuest(JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
        player:setCharVar('StormsOfFate', 0)
    end
end
