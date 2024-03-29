-----------------------------------
-- Area: South Gustaberg
--  MOB: Rock Lizard
-- Note: Place holder Leaping Lizzy
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 80, 1, xi.regime.type.FIELDS)
end

function onMobDespawn(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LEAPING_LIZZY_PH, 5, 1800) -- 30m respawn
end
