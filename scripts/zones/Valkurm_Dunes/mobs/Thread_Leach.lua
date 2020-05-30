-----------------------------------
-- Area: Valkurm Dunes
--  MOB: Snipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 8, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 9, 2, tpz.regime.type.FIELDS)
    if (math.random(1,100) > 90 and isKiller == true) then
        player:addTreasure(14206,mob);
    end
end;
