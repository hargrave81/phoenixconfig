-----------------------------------
-- Area: Valkurm Dunes
--  MOB: Damselfly
-- Note: Place holder Valkurm Emperor
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs");
require("scripts/globals/regimes")
require("scripts/globals/mobs");

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 9, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 10, 2, tpz.regime.type.FIELDS)
    if (math.random(1,100) > 90 and isKiller == true) then
        player:addTreasure(15147,mob);
    end
end;

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob,ID.mob.VALKURM_EMPEROR_PH,5,1800); -- 30m respawn
end;
