-----------------------------------
-- Area: South Gustaberg
--  MOB: Leaping Lizzy
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
        -- random change to get the boots
        if (math.random(1,100) > 95 and isKiller == true) then 
            player:addTreasure(13014,mob);
        end
end
