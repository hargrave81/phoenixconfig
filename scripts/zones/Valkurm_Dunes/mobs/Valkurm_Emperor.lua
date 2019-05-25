----------------------------------
-- Area: Valkurm Dunes
--  NM:  Valkurm Emperor
-----------------------------------

function onMobDeath(mob, player, isKiller)
    -- random change to get the real hairpin
    if (math.random(1,100) > 95 and isKiller == true) then 
        player:addTreasure(12486,mob);
    end
end;
