-----------------------------------
-- Area: Promyvion-Holla
--   NM: Seether
-----------------------------------

gear_listB = {14858,14856,14854,14860} -- hands
gear_listA = {16819,17775,17940,18090,18212,18605,18610,17514,16497,16545,17739, 19105}
 -- mithran scimitar, fukuro, militar pick, militar spear, militar axe, melampus staff, spiro staff, 
 -- hydro calws, slep dagger, broad sword, steel killj, thugs jambiya

function onMobDeath(mob, player, isKiller)
    -- random armor drop    
    local luck = math.random(1,100)
    if (luck > 99 and isKiller == true) then
        local itemId = gear_listA[math.random(1,12)]
        player:addTreasure(itemId,mob);    
    elseif (luck > 94 and isKiller == true) then
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