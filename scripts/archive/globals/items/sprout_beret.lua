-----------------------------------------
-- ID: 14671
-- Item: Sprout Beret
-- Experience point bonus
-----------------------------------------
-- Bonus: +150%
-- Duration: 720 min
-- Max bonus: 30000 exp
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(xi.effect.DEDICATION) == true) then
        result = 56
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(xi.effect.DEDICATION,150,0,43200,0,30000)
end