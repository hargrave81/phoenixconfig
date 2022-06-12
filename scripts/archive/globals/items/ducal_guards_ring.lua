-----------------------------------------
-- ID: 14657
-- Item: ducal guards ring
-- Jeuno Warp
-----------------------------------------
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT,0,tpz.teleport.id.MAAT,0,1)
end