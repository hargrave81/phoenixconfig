-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Mee_Deggi_the_Punisher
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
            -- random change to get the boots
            if (math.random(1,100) > 85 and isKiller == true) then 
                player:addTreasure(13952,mob); -- ochiudos kote
            end
end