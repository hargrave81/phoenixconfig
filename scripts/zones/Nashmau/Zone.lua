-----------------------------------
--
-- Zone: Nashmau (53)
--
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs");
require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end;

function onZoneIn(player,prevZone)
    local cs = -1;
    player:setVar("AlZahbiFastShip",0)
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == dsp.zone.ARRAPAGO_REEF and player:getCurrentMission(TOAU) == dsp.mission.id.toau.THE_BLACK_COFFIN and player:getVar("AhtUrganStatus") == 3) then
            cs = 281;
            player:setPos(-13,2,-62,194);
        elseif (prevZone == dsp.zone.SILVER_SEA_ROUTE_TO_NASHMAU) then
            cs = 201;
            player:setPos(11,2,-102,128);
        else
            player:setPos(40.658,-7.527,-24.001,128);
        end
    end

    return cs;
end;

function onRegionEnter(player,region)
end;

function onRegionLeave(player,region)
end;

function onTransportEvent(player,transport)
    if (transport == 59) then
        player:startEvent(200);
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if (csid == 200) then
        player:setPos(0,-2,0,0,59);
    elseif (csid == 281) then
        player:completeMission(TOAU,dsp.mission.id.toau.THE_BLACK_COFFIN);
        player:setVar("AhtUrganStatus", 0)
        player:addMission(TOAU,dsp.mission.id.toau.GHOSTS_OF_THE_PAST_TOAU);
    end
end;
