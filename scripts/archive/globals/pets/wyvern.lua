-----------------------------------
--  PET: Wyvern
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/ability")
require("scripts/globals/msg")

local WYVERN_OFFENSIVE = 1
local WYVERN_DEFENSIVE = 2
local WYVERN_MULTI = 3

local wyvernTypes =
{
    [xi.job.WAR] = WYVERN_OFFENSIVE,
    [xi.job.MNK] = WYVERN_OFFENSIVE,
    [xi.job.WHM] = WYVERN_DEFENSIVE,
    [xi.job.BLM] = WYVERN_DEFENSIVE,
    [xi.job.RDM] = WYVERN_DEFENSIVE,
    [xi.job.THF] = WYVERN_OFFENSIVE,
    [xi.job.PLD] = WYVERN_MULTI,
    [xi.job.DRK] = WYVERN_MULTI,
    [xi.job.BST] = WYVERN_OFFENSIVE,
    [xi.job.BRD] = WYVERN_MULTI,
    [xi.job.RNG] = WYVERN_OFFENSIVE,
    [xi.job.SAM] = WYVERN_OFFENSIVE,
    [xi.job.NIN] = WYVERN_MULTI,
    [xi.job.DRG] = WYVERN_OFFENSIVE,
    [xi.job.SMN] = WYVERN_DEFENSIVE,
    [xi.job.BLU] = WYVERN_DEFENSIVE,
    [xi.job.COR] = WYVERN_OFFENSIVE,
    [xi.job.PUP] = WYVERN_OFFENSIVE,
    [xi.job.DNC] = WYVERN_OFFENSIVE,
    [xi.job.SCH] = WYVERN_DEFENSIVE,
    [xi.job.GEO] = WYVERN_DEFENSIVE,
    [xi.job.RUN] = WYVERN_MULTI,
}

function doHealingBreath(player, threshold, breath)
    local breath_heal_range = 13
    local function inBreathRange(target)
        return player:getPet():getZoneID() == target:getZoneID() and player:getPet():checkDistance(target) <= breath_heal_range
    end

    if player:getHPP() < threshold and inBreathRange(player) then
        player:getPet():useJobAbility(breath, player)
    else
        local party = player:getParty()
        for _, member in ipairs(party) do
            if member:getHPP() < threshold and inBreathRange(member) then
                player:getPet():useJobAbility(breath, member)
                break
            end
        end
    end
end

function doStatusBreath(target, player)
    local usedBreath = true
    local wyvern = player:getPet()

    if target:hasStatusEffect(xi.effect.POISON) then
        wyvern:useJobAbility(xi.jobAbility.REMOVE_POISON, target)
    elseif target:hasStatusEffect(xi.effect.BLINDNESS) and wyvern:getMainLvl() > 20 then
        wyvern:useJobAbility(xi.jobAbility.REMOVE_BLINDNESS, target)
    elseif target:hasStatusEffect(xi.effect.PARALYSIS) and wyvern:getMainLvl() > 40 then
        wyvern:useJobAbility(xi.jobAbility.REMOVE_PARALYSIS, target)
    elseif (target:hasStatusEffect(xi.effect.CURSE_I) or target:hasStatusEffect(xi.effect.DOOM)) and wyvern:getMainLvl() > 60 then
        wyvern:useJobAbility(xi.jobAbility.REMOVE_CURSE, target)
    elseif (target:hasStatusEffect(xi.effect.DISEASE) or target:hasStatusEffect(xi.effect.PLAGUE)) and wyvern:getMainLvl() > 80 then
        wyvern:useJobAbility(xi.jobAbility.REMOVE_DISEASE, target)
    else
        usedBreath = false
    end

    return usedBreath
end

function onMobSpawn(mob)
    local master = mob:getMaster()
    
	mob:addMod(xi.mod.DMG, -40)
    mob:addMod(xi.mod.DEFP, 50)

	if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.HP, 74)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.HP, 50)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.HP, 25)
	end

	if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.DEF, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.DEF, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.DEF, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(xi.mod.DEF, 10)
	end
	
	if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.MEVA, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.MEVA, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.MEVA, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(xi.mod.MEVA, 10)
	end
	 
    
	if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.ACC, 47)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.ACC, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.ACC, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(xi.mod.ACC, 10)
	end
	 
	if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.MACC, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.MACC, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.MACC, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(xi.mod.MACC, 10)
	end
   
   if mob:getMainLvl() >= 70 then
		mob:addMod(xi.mod.EVA, 46)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(xi.mod.EVA, 34)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(xi.mod.EVA, 21)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(xi.mod.EVA, 10)
	end
    if master:getMod(xi.mod.WYVERN_SUBJOB_TRAITS) > 0 then
        mob:addJobTraits(master:getSubJob(), master:getSubLvl())
    end
    local wyvernType = wyvernTypes[master:getSubJob()]
    local healingbreath = xi.jobAbility.HEALING_BREATH
    if mob:getMainLvl() >= 80 then healingbreath = xi.jobAbility.HEALING_BREATH_IV
    elseif mob:getMainLvl() >= 40 then healingbreath = xi.jobAbility.HEALING_BREATH_III
    elseif mob:getMainLvl() >= 20 then healingbreath = xi.jobAbility.HEALING_BREATH_II
    end
    if wyvernType == WYVERN_DEFENSIVE then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            if not doStatusBreath(player, player) then
                local party = player:getParty()
                for _, member in ipairs(party) do
                    if doStatusBreath(member, player) then
                        break
                    end
                end
            end
        end)
        if master:getSubJob() ~= xi.job.SMN then
            master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
                -- check master first!
                local threshold = 33
                if player:getMod(xi.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                    threshold = 50
                end
                doHealingBreath(player, threshold, healingbreath)
            end)
        end
    elseif wyvernType == WYVERN_OFFENSIVE or wyvernType == WYVERN_MULTI then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            local weaknessTargetChance = 75
            local breaths = {}
            if player:getMod(xi.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                weaknessTargetChance = 100
            end
            if math.random(100) <= weaknessTargetChance then
                local breathList =
                {
                    xi.jobAbility.FLAME_BREATH,
                    xi.jobAbility.FROST_BREATH,
                    xi.jobAbility.GUST_BREATH,
                    xi.jobAbility.SAND_BREATH,
                    xi.jobAbility.LIGHTNING_BREATH,
                    xi.jobAbility.HYDRO_BREATH,
                }
                local resistances =
                {
                    target:getMod(xi.mod.SDT_FIRE),
                    target:getMod(xi.mod.SDT_ICE),
                    target:getMod(xi.mod.SDT_WIND),
                    target:getMod(xi.mod.SDT_EARTH),
                    target:getMod(xi.mod.SDT_THUNDER),
                    target:getMod(xi.mod.SDT_WATER),
                }
                local lowest = resistances[1]
                local breath = breathList[1]
                for i, v in ipairs(breathList) do
                    if resistances[i] > lowest then
                        lowest = resistances[i]
                        breath = v
                    end
                end
                table.insert(breaths, breath)
            else
                breaths =
                {
                    xi.jobAbility.FLAME_BREATH,
                    xi.jobAbility.FROST_BREATH,
                    xi.jobAbility.GUST_BREATH,
                    xi.jobAbility.SAND_BREATH,
                    xi.jobAbility.LIGHTNING_BREATH,
                    xi.jobAbility.HYDRO_BREATH,
                }
            end
            player:getPet():useJobAbility(breaths[math.random(#breaths)], target)
        end)
    end
    if wyvernType == WYVERN_MULTI then
        master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
            -- check master first!
            local threshold = 25
            if player:getMod(xi.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                threshold = 33
            end
            doHealingBreath(player, threshold, healingbreath)
        end)
    end

    master:addListener("ATTACK", "PET_WYVERN_ENGAGE", function(player, target, action)
        local pet = player:getPet()
        if pet:getTarget() == nil or target:getID() ~= pet:getTarget():getID() then
            player:petAttack(target)
        end
    end)

    master:addListener("DISENGAGE", "PET_WYVERN_DISENGAGE", function(player)
        player:petRetreat()
    end)

    master:addListener("EXPERIENCE_POINTS", "PET_WYVERN_EXP", function(player, exp)
        local pet = player:getPet()
        local prev_exp = pet:getLocalVar("wyvern_exp")
        if prev_exp < 1000 then
            -- cap exp at 1000 to prevent wyvern leveling up many times from large exp awards
            local currentExp = exp
            if prev_exp + exp > 1000 then
                currentExp = 1000 - prev_exp
            end
            local diff = math.floor((prev_exp + currentExp) / 200) - math.floor(prev_exp / 200)
            if diff ~= 0 then
                -- wyvern levelled up (diff is the number of level ups)
                pet:addMod(xi.mod.ACC, 6 * diff)
                pet:addMod(xi.mod.HPP, 6 * diff)
                pet:addMod(xi.mod.ATTP, 5 * diff)
                pet:setHP(pet:getMaxHP())
                player:messageBasic(xi.msg.basic.STATUS_INCREASED, 0, 0, pet)
                master:addMod(xi.mod.ATTP, 4 * diff)
                master:addMod(xi.mod.DEFP, 4 * diff)
            end
            pet:setLocalVar("wyvern_exp", prev_exp + exp)
            pet:setLocalVar("level_Ups", pet:getLocalVar("level_Ups") + diff)
        end
    end)
end

function onMobFight(mob, target)
    local master = mob:getMaster()
    -- Add item mods
    local Learring = master:getEquipID(xi.slot.EAR1)
    local Rearring = master:getEquipID(xi.slot.EAR2)
    if Learring == 16000 or Rearring == 16000 then -- Dragoon's Earring
	    if mob:getMainLvl() >= 70 then
		    mob:setMod(xi.mod.MACC, 68)
	    elseif mob:getMainLvl() >= 50 then
	        mob:setMod(xi.mod.MACC, 55)
	    elseif mob:getMainLvl() >= 30 then
	        mob:setMod(xi.mod.MACC, 42)
	    elseif mob:getMainLvl() >= 10 then
	        mob:setMod(xi.mod.MACC, 20)
	    end
    else
 	    if mob:getMainLvl() >= 70 then
		    mob:setMod(xi.mod.MACC, 48)
	    elseif mob:getMainLvl() >= 50 then
	        mob:setMod(xi.mod.MACC, 35)
	    elseif mob:getMainLvl() >= 30 then
	        mob:setMod(xi.mod.MACC, 22)
	    elseif mob:getMainLvl() >= 10 then
	        mob:setMod(xi.mod.MACC, 10)
	    end       
    end
    -- Spirit power logic(Spirit Surge)
    local SpiritPower = master:getLocalVar("SpiritPower")
    if SpiritPower > 0 then
        mob:setMod(xi.mod.ATTP, SpiritPower * 15)
    else
        mob:setMod(xi.mod.ATTP, 0)
    end
end

function onMobDeath(mob, player)
    local master = mob:getMaster()
    local numLvls = mob:getLocalVar("level_Ups")
    if numLvls ~= 0 then
        master:delMod(xi.mod.ATTP, 4 * numLvls)
        master:delMod(xi.mod.DEFP, 4 * numLvls)
        master:delMod(xi.mod.HASTE_ABILITY, 200 * numLvls)
    end
    master:removeListener("PET_WYVERN_WS")
    master:removeListener("PET_WYVERN_MAGIC")
    master:removeListener("PET_WYVERN_ENGAGE")
    master:removeListener("PET_WYVERN_DISENGAGE")
    master:removeListener("PET_WYVERN_EXP")
end
