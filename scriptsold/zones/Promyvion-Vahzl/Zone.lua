-----------------------------------
-- Zone: Promyvion-Vahzl (22)
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/promyvion")
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
        player:setPos(-14.744, 0.036, -119.736, 1) -- To Floor 1 {R}
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if xi.settings.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 52, 0, 0)
    end
end

zone_object.onRegionEnter = function(player, region)
    xi.promyvion.onRegionEnter(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 45 and option == 1 then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja {R}
    end
end

return zone_object
