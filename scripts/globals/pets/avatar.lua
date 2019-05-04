-----------------------------------
--  PET: Elementals
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/weather")

function onMobDeath(mob, player, isKiller)

end;

function onPetRoam(pet)

end;

function onPetEngage(pet,delay)
    local master = pet:getMaster()    
    local spellDelay = delay
    if (pet:getSystem() == 11) then
        master:PrintToPlayer("Elemental Detected");
        local smnSkill = getSummoningSkillOverCap(pet)
        delay = getTimeCost(pet)
        delay = delay + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)
        if player:hasStatusEffect(dsp.effect.ASTRAL_FLOW) then
            delay = spellDelay / 2
        else if(smnSkill > 0) then
            master:PrintToPlayer("You might cast on start");
            -- we have a chance right on engage near instantly
            if(math.random(0,99) < 25) then
                delay = spellDelay / 2
            end
        end
    end
    if delay < 0 then
        delay = 0
    end
  return delay
end;


function onPetFight(pet,target,delay)
    local master = pet:getMaster()   
    if (pet:getSystem() == 11) then             
        delay = getTimeCost(pet)
        delay = delay + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)
        if player:hasStatusEffect(dsp.effect.ASTRAL_FLOW) then
            delay = delay - 5000
        end
    end
    if delay < 0 then
        delay = 0
    end
  return delay
end;

function getGearMod(master)
    -- Summoner's spats
    local leg = player:getEquipID(dsp.slot.LEGS);
    if leg == 15131 or leg == 15594 then
        return -5000
    end    
    return 0
end

function getWeatherMod(avatar)
    local element = avatar:getPetElement()
    local ms = -2000
    local sms = -6000 -- Retail does not have this effect, double weather gives faster casting
    if player:getWeather() == dsp.weather.SNOW and element == dsp.subEffect.ICE_DAMAGE then
      return ms
    else if player:getWeather() == dsp.weather.BLIZZARDS and (element == dsp.subEffect.ICE_DAMAGE or element == dsp.subEffect.FIRE_DAMAGE) then
      return sms
    else if player:getWeather() == dsp.weather.WIND and element == dsp.subEffect.WIND_DAMAGE then
      return ms
    else if player:getWeather() == dsp.weather.GALES and (element == dsp.subEffect.WIND_DAMAGE or element == dsp.subEffect.ICE_DAMAGE) then
      return sms
    else if player:getWeather() == dsp.weather.DUST_STORM and element == dsp.subEffect.EARTH_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.SAND_STORM and (element == dsp.subEffect.EARTH_DAMAGE or element == dsp.subEffect.WIND_DAMAGE) then
        return sms
    else if player:getWeather() == dsp.weather.THUNDER and element == dsp.subEffect.LIGHTNING_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.THUNDERSTORMS and (element == dsp.subEffect.LIGHTNING_DAMAGE or element == dsp.subEffect.EARTH_DAMAGE) then
        return sms
    else if player:getWeather() == dsp.weather.RAIN and element == dsp.subEffect.WATER_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.SQUALL and element == (dsp.subEffect.WATER_DAMAGE or element == dsp.subEffect.LIGHTNING_DAMAGE) then
        return sms
    else if player:getWeather() == dsp.weather.HOT_SPELL and element == dsp.subEffect.FIRE_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.HEAT_WAVE and element == (dsp.subEffect.FIRE_DAMAGE or element == dsp.subEffect.WATER_DAMAGE) then
        return sms
    else if player:getWeather() == dsp.weather.AURORAS and element == dsp.subEffect.LIGHT_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.STELLAR_GLARE and element == dsp.subEffect.LIGHT_DAMAGE then
        return sms
    else if player:getWeather() == dsp.weather.GLOOM and element == dsp.subEffect.DARKNESS_DAMAGE then
        return ms
    else if player:getWeather() == dsp.weather.DARKNESS and element == dsp.subEffect.DARKNESS_DAMAGE then
        return sms
    else if player:getWeather() == dsp.weather.SNOW and element == dsp.subEffect.WIND_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.BLIZZARDS and element == dsp.subEffect.WIND_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.WIND and element == dsp.subEffect.EARTH_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.GALES and element == dsp.subEffect.EARTH_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.DUST_STORM and element == dsp.subEffect.LIGHTNING_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.SAND_STORM and element == dsp.subEffect.LIGHTNING_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.THUNDER and element == dsp.subEffect.WATER_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.THUNDERSTORMS and element == dsp.subEffect.WATER_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.RAIN and element == dsp.subEffect.FIRE_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.SQUALL and element == dsp.subEffect.FIRE_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.HOT_SPELL and element == dsp.subEffect.ICE_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.HEAT_WAVE and element == dsp.subEffect.ICE_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.AURORAS and element == dsp.subEffect.DARKNESS_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.STELLAR_GLARE and element == dsp.subEffect.DARKNESS_DAMAGE then
        return sms * - 1
    else if player:getWeather() == dsp.weather.GLOOM and element == dsp.subEffect.LIGHT_DAMAGE then
        return ms * - 1
    else if player:getWeather() == dsp.weather.DARKNESS and element == dsp.subEffect.LIGHT_DAMAGE then
        return sms * - 1
    end
    return 0
end

function getDayMod(avatar)
    local element = avatar:getPetElement()
    local ms = -3000    
    if VanadielDayElement() == dsp.day.ICEDAY and element == dsp.subEffect.ICE_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.ICEDAY and element == dsp.subEffect.WIND_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.WINDSDAY and element == dsp.subEffect.WIND_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.WINDSDAY and element == dsp.subEffect.EARTH_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.EARTHSDAY and element == dsp.subEffect.EARTH_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.EARTHSDAY and element == dsp.subEffect.LIGHTNING_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.LIGHTNINGDAY and element == dsp.subEffect.LIGHTNING_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.LIGHTNINGDAY and element == dsp.subEffect.WATER_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.WATERSDAY and element == dsp.subEffect.WATER_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.WATERSDAY and element == dsp.subEffect.FIRE_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.FIRESDAY and element == dsp.subEffect.FIRE_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.FIRESDAY and element == dsp.subEffect.ICE_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.LIGHTSDAY and element == dsp.subEffect.LIGHT_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.LIGHTSDAY and element == dsp.subEffect.DARKNESS_DAMAGE then
       return ms * - 1
    if VanadielDayElement() == dsp.day.DARKSDAY and element == dsp.subEffect.DARKNESS_DAMAGE then
       return ms
    else if VanadielDayElement() == dsp.day.DARKSDAY and element == dsp.subEffect.LIGHT_DAMAGE then
       return ms * - 1    
    end
    return 0
end

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(dsp.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), dsp.job.SMN, dsp.skill.SUMMONING_MAGIC)
    return math.max(summoningSkill - maxSkill, 0)
end

function getTimeCost(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(dsp.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), dsp.job.SMN, dsp.skill.SUMMONING_MAGIC)
    return 45 - (summoningSkill - maxSkill)/3
end