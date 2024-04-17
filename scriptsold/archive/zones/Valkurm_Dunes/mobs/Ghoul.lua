-----------------------------------
-- Area: Valkurm Dunes
--  MOB: Ghoul
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if (math.random(1,100) > 90 and isKiller == true) then
        player:addTreasure(13818,mob);
    end
end;
