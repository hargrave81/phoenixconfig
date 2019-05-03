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
    master:PrintToPlayer("Pet Engaged");
    if (pet:getFamily() == 11) then
        master:PrintToPlayer("Elemental Detected");
        local smnSkill = getSummoningSkillOverCap(pet)
        delay = getTimeCost(pet)
        delay = delay + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)
        -- decide if we are going to cast on start or not
        if(smnSkill > 0) then
            master:PrintToPlayer("You might cast on start");
            -- we have a chance to cast on engage
            if(math.random(0,99) < 25) then
                delay = 0
            end
        end
    end
  return delay
end;


function onPetFight(pet,target,delay)
    local master = pet:getMaster()
    master:PrintToPlayer("Pet Engaged");
    if (pet:getFamily() == 11) then     
        master:PrintToPlayer("Elemental Detected");   
        delay = getTimeCost(pet)
        delay = delay + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)
        -- TODO add astral flow reduction
    end
  return delay
end;

function getGearMod(master)
    return 0
end

function getWeatherMod(avatar)
    if player:getWeather() == WEATHER_ICE or player:getWeather() == dsp.weather.BLIZZARDS then
      return 6
    end
    return 0
end

function getDayMod(avatar)
    if VanadielDayElement() == dsp.day.ICEDAY then
       return 6
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