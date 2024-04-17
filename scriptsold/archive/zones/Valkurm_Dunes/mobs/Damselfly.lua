-----------------------------------
-- Area: Valkurm Dunes
--  MOB: Damselfly
-- Note: Place holder Valkurm Emperor
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs");
require("scripts/globals/regimes")
require("scripts/globals/mobs");

function onMobDeath(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 10, 2, xi.regime.type.FIELDS)
    if (math.random(1,100) > 90 and isKiller == true) then
        player:addTreasure(15147,mob);
    end
end;

function onMobDespawn(mob)
    xi.mob.phOnDespawn(mob,ID.mob.VALKURM_EMPEROR_PH,5,1800); -- 30m respawn
end;
