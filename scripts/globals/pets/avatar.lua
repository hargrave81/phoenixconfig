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

function onMobSpawn(pet)
    local master = pet:getMaster()        
    local mLvl = master:getMainLvl()
    local foodPower = 3 + (mLvl / 10)
    
    local summoningSkill = master:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
    local boost = math.max(.5,summoningSkill / master:getMaxSkillLevel(master:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC))
    
    pet:addStatusEffect(tpz.effect.DEF_BOOST,foodPower*1.75*boost,0,9600,0,0)
    pet:addStatusEffect(tpz.effect.STR_BOOST,foodPower*boost,0,9600,0,0)    
    
    if (pet:getSystem() == 11) then         -- elemental spirit        
        pet:addStatusEffect(tpz.effect.INT_BOOST,(foodPower*1.4)*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.DEFENSE_BOOST,foodPower*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.MND_BOOST,foodPower*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.MAX_HP_BOOST,foodPower*boost,0,9600,0,0)
    else
        if pet:getFamily() == 379 or pet:getFamily() == 34 then
            foodPower = foodPower * .7
        end
        pet:addStatusEffect(tpz.effect.MAX_HP_BOOST,foodPower*2.9*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.MND_BOOST,foodPower*2*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.INT_BOOST,foodPower*2*boost,0,9600,0,0)        
        pet:addStatusEffect(tpz.effect.ATTACK_BOOST,foodPower*2*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.ACCURACY_BOOST,foodPower*1.5*boost,0,9600,0,0)
        pet:addStatusEffect(tpz.effect.DEFENSE_BOOST,foodPower*2.5*boost,0,9600,0,0)
    end
    local diff = (pet:getMaxHP() - pet:getHP())
    pet:addHP(diff)
end

-- on engage, return the delay reduction based on skill to cast on battle start
function onPetEngage(pet,delay)
    -- return incoming delay value to return to legacy/monster mode        
    local master = pet:getMaster()        
        
    local fastCast = 0
    if (pet:getSystem() == 11) then      -- elemental spirit   
        local smnSkill = getSummoningSkillOverCap(pet)
        fastCast  = getTimeCost(pet)
        fastCast  = fastCast + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)
        if master:hasStatusEffect(tpz.effect.ASTRAL_FLOW) then
            delay = fastCast -- this will make the reduction the entire delay
        elseif smnSkill > 0 then            
            -- randomly cast on fight start
            if math.random(0,99) < 25 then
                delay = fastCast
            end
        end
    end
    return delay
end;

-- on each fight round, adjust delay to match smn skill
function onPetFight(pet,target,delay)
    -- return the value provided in delay to resume legacy monster mode
    local master = pet:getMaster()   
    if (pet:getSystem() == 11) then         -- elemental spirit
        delay = getTimeCost(pet) -- base 45s and adjusted based on skill        
        delay = delay + getGearMod(pet:getMaster()) + getWeatherMod(pet) + getDayMod(pet)        
        if master:hasStatusEffect(tpz.effect.ASTRAL_FLOW) then
            delay = delay - 5000
        end
    end
    if delay < 0 then
        delay = 0
    end
    return delay
end;

-- return true if you are casting a spell, otherwise return false
function onPetRoam(pet, msSinceLastCast)
    if (pet:getFamily() == 104) then      -- light spirit         
        local master = pet:getMaster()
        local level = pet:getMainLvl()
        local fastCast  = getTimeCost(pet)
        fastCast = fastCast + getGearMod(master) + getWeatherMod(pet) + getDayMod(pet)    
        if msSinceLastCast > fastCast / 2 then -- light spirit casts twice as frequent            
            -- decide if we want to buff the master with something
            -- does master need healing?
            -- does his friends?
            -- does master need shielding?
            -- does master need speeding up?
            -- lets regen master                
            local masterHP1 = master:getHPP() < 70
            local masterHP2 = master:getHPP() < 90            
            local partyHP = false
            local party = master:getParty()            
            for _,member in ipairs(party) do
                if member:getHPP() < 50 then                    
                    partyHP = true
                    break
                end
            end      
            if masterHP1 and partyHP and level > 15 then --curaga                
                pet:castSpell(level >= 91 and 11 or level >= 71 and 10 or level >= 51 and 9 or level >= 31 and 8 or 7, master)
                return true
            elseif masterHP1 then --cure                
                pet:castSpell(level >= 80 and 6 or level >= 61 and 5 or level >= 41 and 4 or level >= 21 and 3 or level >= 11 and 2 or 1, master)
                return true
            end
            local casted = buffPlayer(master,pet,level)
            if casted == true then return true end
            if partyHP then -- cure                
                for _,member in ipairs(party) do
                    if member:getHPP() < 50 then                    
                        pet:castSpell(level >= 80 and 6 or level >= 61 and 5 or level >= 41 and 4 or level >= 21 and 3 or level >= 11 and 2 or 1, member)
                        return true
                    end
                end      
            end                       
            for _,member in ipairs(party) do                
                if math.random(0,99) < 50 then -- pick a player somewhat at random                    
                    casted = buffPlayer(member,pet,level)
                    if casted == true then return true end
                end
            end
            if masterHP2 then -- low cure                
                pet:castSpell(level >= 30 and 3 or level >= 20 and 2 or 1, master)
                return true
            end                       
        end        
    end
    return false
end;

function buffPlayer(player,pet,level)        
    if not player:hasStatusEffect(tpz.effect.PROTECT) and level >= 7 then -- protect        
        local sp = level >= 76 and 47 or level >= 63 and 46 or level >= 47 and 45 or level >= 27 and 44 or 43                
        pet:castSpell(sp, player)
        return true
    end
    if not player:hasStatusEffect(tpz.effect.SHELL) and level >= 17 then -- shell        
        pet:castSpell(level >= 76 and 52 or level >= 68 and 51 or level >= 57 and 50 or level >= 37 and 49 or 48, player)
        return true
    end
    if not player:hasStatusEffect(tpz.effect.HASTE) and level >= 40 then -- haste        
        pet:castSpell(57, player)
        return true
    end
    if not player:hasStatusEffect(tpz.effect.REGEN) and level >= 21 then -- regen        
        pet:castSpell(level >= 86 and 477 or level >= 66 and 111 or level >= 44 and 110 or 108, player)
        return true
    end
    return false
end;

function getGearMod(master)
    -- Summoner's spats
    local leg = master:getEquipID(tpz.slot.LEGS);
    if leg == 15131 or leg == 15594 then
        return -5000
    end    
    return 0
end;

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC)
    return math.max(summoningSkill - maxSkill, 0)
end;

function getTimeCost(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC)
    -- 45 s +/- 1 second for every 3 skill over or under cap
    return 35000 - ((summoningSkill - maxSkill)/3) * 1000
end;

function getElement(avatar)
    --avatar:getPetElement()     this doesn't return anything but zer0
    if (avatar:getFamily() == 99) then             
        return tpz.subEffect.WIND_DAMAGE
    elseif (avatar:getFamily() == 100) then
        return tpz.subEffect.DARKNESS_DAMAGE             
    elseif (avatar:getFamily() == 101) then             
        return tpz.subEffect.EARTH_DAMAGE
    elseif (avatar:getFamily() == 102) then             
        return tpz.subEffect.FIRE_DAMAGE
    elseif (avatar:getFamily() == 103) then             
        return tpz.subEffect.ICE_DAMAGE
    elseif (avatar:getFamily() == 104) then             
        return tpz.subEffect.LIGHT_DAMAGE
    elseif (avatar:getFamily() == 105) then             
        return tpz.subEffect.LIGHTNING_DAMAGE
    elseif (avatar:getFamily() == 106) then             
        return tpz.subEffect.WATER_DAMAGE
    end
end;

function getWeatherMod(avatar)
    local element = getElement(avatar)
    local summoner = avatar:getMaster()
    local ms = -2000
    local sms = -6000 -- can increase this if you want stronger double weather effect    
    if summoner:getWeather() == tpz.weather.SNOW and element == tpz.subEffect.ICE_DAMAGE then
      return ms
    elseif summoner:getWeather() == tpz.weather.BLIZZARDS and (element == tpz.subEffect.ICE_DAMAGE or element == tpz.subEffect.FIRE_DAMAGE) then
      return sms
    elseif summoner:getWeather() == tpz.weather.WIND and element == tpz.subEffect.WIND_DAMAGE then
      return ms
    elseif summoner:getWeather() == tpz.weather.GALES and (element == tpz.subEffect.WIND_DAMAGE or element == tpz.subEffect.ICE_DAMAGE) then
      return sms
    elseif summoner:getWeather() == tpz.weather.DUST_STORM and element == tpz.subEffect.EARTH_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.SAND_STORM and (element == tpz.subEffect.EARTH_DAMAGE or element == tpz.subEffect.WIND_DAMAGE) then
        return sms
    elseif summoner:getWeather() == tpz.weather.THUNDER and element == tpz.subEffect.LIGHTNING_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.THUNDERSTORMS and (element == tpz.subEffect.LIGHTNING_DAMAGE or element == tpz.subEffect.EARTH_DAMAGE) then
        return sms
    elseif summoner:getWeather() == tpz.weather.RAIN and element == tpz.subEffect.WATER_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.SQUALL and element == (tpz.subEffect.WATER_DAMAGE or element == tpz.subEffect.LIGHTNING_DAMAGE) then
        return sms
    elseif summoner:getWeather() == tpz.weather.HOT_SPELL and element == tpz.subEffect.FIRE_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.HEAT_WAVE and element == (tpz.subEffect.FIRE_DAMAGE or element == tpz.subEffect.WATER_DAMAGE) then
        return sms
    elseif summoner:getWeather() == tpz.weather.AURORAS and element == tpz.subEffect.LIGHT_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.STELLAR_GLARE and element == tpz.subEffect.LIGHT_DAMAGE then
        return sms
    elseif summoner:getWeather() == tpz.weather.GLOOM and element == tpz.subEffect.DARKNESS_DAMAGE then
        return ms
    elseif summoner:getWeather() == tpz.weather.DARKNESS and element == tpz.subEffect.DARKNESS_DAMAGE then
        return sms
    elseif summoner:getWeather() == tpz.weather.SNOW and element == tpz.subEffect.WIND_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.BLIZZARDS and element == tpz.subEffect.WIND_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.WIND and element == tpz.subEffect.EARTH_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.GALES and element == tpz.subEffect.EARTH_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.DUST_STORM and element == tpz.subEffect.LIGHTNING_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.SAND_STORM and element == tpz.subEffect.LIGHTNING_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.THUNDER and element == tpz.subEffect.WATER_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.THUNDERSTORMS and element == tpz.subEffect.WATER_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.RAIN and element == tpz.subEffect.FIRE_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.SQUALL and element == tpz.subEffect.FIRE_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.HOT_SPELL and element == tpz.subEffect.ICE_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.HEAT_WAVE and element == tpz.subEffect.ICE_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.AURORAS and element == tpz.subEffect.DARKNESS_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.STELLAR_GLARE and element == tpz.subEffect.DARKNESS_DAMAGE then
        return sms * - 1
    elseif summoner:getWeather() == tpz.weather.GLOOM and element == tpz.subEffect.LIGHT_DAMAGE then
        return ms * - 1
    elseif summoner:getWeather() == tpz.weather.DARKNESS and element == tpz.subEffect.LIGHT_DAMAGE then
        return sms * - 1
    end
    return 0
end;

function getDayMod(avatar)
    local element = getElement(avatar)
    local ms = -3000    
    local summoner = avatar:getMaster()    
    if VanadielDayElement() == tpz.day.ICEDAY and element == tpz.subEffect.ICE_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.ICEDAY and element == tpz.subEffect.WIND_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.WINDSDAY and element == tpz.subEffect.WIND_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.WINDSDAY and element == tpz.subEffect.EARTH_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.EARTHSDAY and element == tpz.subEffect.EARTH_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.EARTHSDAY and element == tpz.subEffect.LIGHTNING_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.LIGHTNINGDAY and element == tpz.subEffect.LIGHTNING_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.LIGHTNINGDAY and element == tpz.subEffect.WATER_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.WATERSDAY and element == tpz.subEffect.WATER_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.WATERSDAY and element == tpz.subEffect.FIRE_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.FIRESDAY and element == tpz.subEffect.FIRE_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.FIRESDAY and element == tpz.subEffect.ICE_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.LIGHTSDAY and element == tpz.subEffect.LIGHT_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.LIGHTSDAY and element == tpz.subEffect.DARKNESS_DAMAGE then
       return ms * - 1
    elseif VanadielDayElement() == tpz.day.DARKSDAY and element == tpz.subEffect.DARKNESS_DAMAGE then
       return ms
    elseif VanadielDayElement() == tpz.day.DARKSDAY and element == tpz.subEffect.LIGHT_DAMAGE then
       return ms * - 1    
    end
    return 0
end;
