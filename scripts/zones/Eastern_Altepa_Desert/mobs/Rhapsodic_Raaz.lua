----------------------------------
-- Area: Eastern Altepa Desert
--  NM:  Rhapsodic Raaz
-----------------------------------

function onMobDeath(mob, player, isKiller)
    -- random change to get a weapon
    local gear = {
        18004, -- trailer kukri
        17841, -- nursemaid's harp
        14761, -- elusive earring
        13691, -- knightly mantle
        15185, -- walkure Mask
        15293, -- gleeman belt
        13176, -- philomath stole
        13175, -- ajari necklace
        14870, -- trainer's wrists
        18172, -- light boomerang
        18087, -- schwarz lance
        17822, -- Omokage
        17788, -- Sairen
        17648, -- dragvandil
        17647, -- aramis rapier
        17574, -- archalaus pole
        17491, -- spartan cesti
        17379, -- hamelin flute
        17235, -- armbrust
        16788, -- vassagos scythe
        16726, -- forestis axe
        16684, -- kabrakans axe
        17187, -- eurytos bow
        17472, -- crosscounters
        17429, -- dominion mace
        17491, -- spartan cesti
        13403, -- assault earing
        17430, -- fey wand
        17615, -- chicken knife
        17190, -- sarnga
        1261 -- light ore - just to make sure the array works
    };
    -- 30 items
    if (math.random(1,100) > 90 and isKiller == true) then                
        local item1 = math.random(30)        
        player:addTreasure(gear[item1],mob);
    end
    if (math.random(1,100) > 98 and isKiller == true) then                
        local item1 = math.random(30)        
        player:addTreasure(gear[item1],mob);
    end
end;
