-----------------------------------
-- Zone: Promyvion-Mea (20)
-----------------------------------
local ID = require("scripts/zones/Promyvion-Mea/IDs")
require("scripts/globals/promyvion")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.promyvion.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-93.268, 0, 170.749, 162) -- Floor 1 {R}
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if xi.settings.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 32, 0, 0)
    end
end

zone_object.onRegionEnter = function(player, region)
    xi.promyvion.onRegionEnter(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, region)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 46 and option == 1 then
        player:setPos(279.988, -86.459, -25.994, 63, 14) -- To Hall of Transferance {R}
    end
end

return zone_object
