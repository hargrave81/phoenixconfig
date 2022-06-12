-----------------------------------
--
-- Zone: Selbina (248)
--
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

function onGameHour(zone)
    SetServerVariable("Selbina_Deastination", math.random(1,100))
end

function onZoneIn(player,prevZone)
    local cs = -1
    player:setCharVar("SelbinaFastShip",0)
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA or prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES then
            cs = 202
            player:setPos(32.500, -2.500, -45.500, 192)
        else
            player:setPos(17.981, -16.806, 99.83, 64)
        end
    end

    if player:hasKeyItem(xi.ki.SEANCE_STAFF) and player:getCharVar("Enagakure_Killed") == 1 then
        cs = 1101
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

function onTransportEvent(player,transport)
    player:startEvent(200)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 200 then
        if GetServerVariable("Selbina_Deastination") > 89 then
            player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES)
        else
            player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_MHAURA)
        end
    elseif csid == 1101 and npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX, {item = 14226, fame_area = NORG, var = {"Enagakure_Killed", "illTakeTheBigBoxCS"}}) then
        player:delKeyItem(xi.ki.SEANCE_STAFF)
    end
end
