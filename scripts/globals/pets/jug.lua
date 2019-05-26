require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")

-- on engage, return the delay reduction based on skill to cast on battle start
function onPetEngage(pet,delay)
    -- return incoming delay value to return to legacy/monster mode        
    local mLvl = master:getMainLvl()
    local foodPower = 3 + (mLvl / 10)
    pet:addStatusEffect(dsp.effect.DEF_BOOST*1.5,foodPower,0,9600,0,0)
    pet:addStatusEffect(dsp.effect.STR_BOOST,foodPower,0,9600,0,0)
    pet:addStatusEffect(dsp.effect.INT_BOOST,foodPower,0,9600,0,0)
end