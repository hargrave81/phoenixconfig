-----------------------------------
-- Area: Promyvion-Dem
--   NM: Gorger
-----------------------------------

gear_listB = {15165,15163,15161,15167} -- head
gear_listA = {14426,14424,14422,14431} -- body

function onMobDeath(mob, player, isKiller)
    -- random armor drop    
    local luck = math.random(1,100)
    if (luck > 94 and isKiller == true) then
        local itemId = gear_listA[math.random(1,4)]
        player:addTreasure(itemId,mob);    
    end
    if (luck > 88 and isKiller == true) then
        local itemId = gear_listB[math.random(1,4)]
        player:addTreasure(itemId,mob);
    end
end

---------------------------
-- shade
-- 14327 - tights
-- 14426 - harness
-- 14858 - mitts
-- 15165 - tiera
-- 15315 - leggins

-- seers
-- 14325 - slacks
-- 14424 - tunic
-- 14856 - mitts
-- 15163 - crown
-- 15313 - pumps

-- noct
-- 14323 - brais
-- 14422 - doublet
-- 14854 - gloves
-- 15161 - beret
-- 15311 - gaiters

-- eisenplatte
-- 14329 - legs
-- 14431 - body
-- 14860 - hands
-- 15167 - head
-- 15317 - feet