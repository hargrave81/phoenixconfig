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
    [tpz.job.WAR] = WYVERN_OFFENSIVE,
    [tpz.job.MNK] = WYVERN_OFFENSIVE,
    [tpz.job.WHM] = WYVERN_DEFENSIVE,
    [tpz.job.BLM] = WYVERN_DEFENSIVE,
    [tpz.job.RDM] = WYVERN_DEFENSIVE,
    [tpz.job.THF] = WYVERN_OFFENSIVE,
    [tpz.job.PLD] = WYVERN_MULTI,
    [tpz.job.DRK] = WYVERN_MULTI,
    [tpz.job.BST] = WYVERN_OFFENSIVE,
    [tpz.job.BRD] = WYVERN_MULTI,
    [tpz.job.RNG] = WYVERN_OFFENSIVE,
    [tpz.job.SAM] = WYVERN_OFFENSIVE,
    [tpz.job.NIN] = WYVERN_MULTI,
    [tpz.job.DRG] = WYVERN_OFFENSIVE,
    [tpz.job.SMN] = WYVERN_DEFENSIVE,
    [tpz.job.BLU] = WYVERN_DEFENSIVE,
    [tpz.job.COR] = WYVERN_OFFENSIVE,
    [tpz.job.PUP] = WYVERN_OFFENSIVE,
    [tpz.job.DNC] = WYVERN_OFFENSIVE,
    [tpz.job.SCH] = WYVERN_DEFENSIVE,
    [tpz.job.GEO] = WYVERN_DEFENSIVE,
    [tpz.job.RUN] = WYVERN_MULTI,
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

    if target:hasStatusEffect(tpz.effect.POISON) then
        wyvern:useJobAbility(tpz.jobAbility.REMOVE_POISON, target)
    elseif target:hasStatusEffect(tpz.effect.BLINDNESS) and wyvern:getMainLvl() > 20 then
        wyvern:useJobAbility(tpz.jobAbility.REMOVE_BLINDNESS, target)
    elseif target:hasStatusEffect(tpz.effect.PARALYSIS) and wyvern:getMainLvl() > 40 then
        wyvern:useJobAbility(tpz.jobAbility.REMOVE_PARALYSIS, target)
    elseif (target:hasStatusEffect(tpz.effect.CURSE_I) or target:hasStatusEffect(tpz.effect.DOOM)) and wyvern:getMainLvl() > 60 then
        wyvern:useJobAbility(tpz.jobAbility.REMOVE_CURSE, target)
    elseif (target:hasStatusEffect(tpz.effect.DISEASE) or target:hasStatusEffect(tpz.effect.PLAGUE)) and wyvern:getMainLvl() > 80 then
        wyvern:useJobAbility(tpz.jobAbility.REMOVE_DISEASE, target)
    else
        usedBreath = false
    end

    return usedBreath
end

function onMobSpawn(mob)
    local master = mob:getMaster()
    
	mob:addMod(tpz.mod.DMG, -40)
    mob:addMod(tpz.mod.DEFP, 50)

	if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.HP, 74)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.HP, 50)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.HP, 25)
	end

	if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.DEF, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.DEF, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.DEF, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(tpz.mod.DEF, 10)
	end
	
	if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.MEVA, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.MEVA, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.MEVA, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(tpz.mod.MEVA, 10)
	end
	 
    
	if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.ACC, 47)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.ACC, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.ACC, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(tpz.mod.ACC, 10)
	end
	 
	if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.MACC, 48)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.MACC, 35)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.MACC, 22)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(tpz.mod.MACC, 10)
	end
   
   if mob:getMainLvl() >= 70 then
		mob:addMod(tpz.mod.EVA, 46)
	elseif mob:getMainLvl() >= 50 then
	    mob:addMod(tpz.mod.EVA, 34)
	elseif mob:getMainLvl() >= 30 then
	    mob:addMod(tpz.mod.EVA, 21)
	elseif mob:getMainLvl() >= 10 then
	    mob:addMod(tpz.mod.EVA, 10)
	end
    if master:getMod(tpz.mod.WYVERN_SUBJOB_TRAITS) > 0 then
        mob:addJobTraits(master:getSubJob(), master:getSubLvl())
    end
    local wyvernType = wyvernTypes[master:getSubJob()]
    local healingbreath = tpz.jobAbility.HEALING_BREATH
    if mob:getMainLvl() >= 80 then healingbreath = tpz.jobAbility.HEALING_BREATH_IV
    elseif mob:getMainLvl() >= 40 then healingbreath = tpz.jobAbility.HEALING_BREATH_III
    elseif mob:getMainLvl() >= 20 then healingbreath = tpz.jobAbility.HEALING_BREATH_II
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
        if master:getSubJob() ~= tpz.job.SMN then
            master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
                -- check master first!
                local threshold = 33
                if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                    threshold = 50
                end
                doHealingBreath(player, threshold, healingbreath)
            end)
        end
    elseif wyvernType == WYVERN_OFFENSIVE or wyvernType == WYVERN_MULTI then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            local weaknessTargetChance = 75
            local breaths = {}
            if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                weaknessTargetChance = 100
            end
            if math.random(100) <= weaknessTargetChance then
                local breathList =
                {
                    tpz.jobAbility.FLAME_BREATH,
                    tpz.jobAbility.FROST_BREATH,
                    tpz.jobAbility.GUST_BREATH,
                    tpz.jobAbility.SAND_BREATH,
                    tpz.jobAbility.LIGHTNING_BREATH,
                    tpz.jobAbility.HYDRO_BREATH,
                }
                local resistances =
                {
                    target:getMod(tpz.mod.SDT_FIRE),
                    target:getMod(tpz.mod.SDT_ICE),
                    target:getMod(tpz.mod.SDT_WIND),
                    target:getMod(tpz.mod.SDT_EARTH),
                    target:getMod(tpz.mod.SDT_THUNDER),
                    target:getMod(tpz.mod.SDT_WATER),
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
                    tpz.jobAbility.FLAME_BREATH,
                    tpz.jobAbility.FROST_BREATH,
                    tpz.jobAbility.GUST_BREATH,
                    tpz.jobAbility.SAND_BREATH,
                    tpz.jobAbility.LIGHTNING_BREATH,
                    tpz.jobAbility.HYDRO_BREATH,
                }
            end
            player:getPet():useJobAbility(breaths[math.random(#breaths)], target)
        end)
    end
    if wyvernType == WYVERN_MULTI then
        master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
            -- check master first!
            local threshold = 25
            if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
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
                pet:addMod(tpz.mod.ACC, 6 * diff)
                pet:addMod(tpz.mod.HPP, 6 * diff)
                pet:addMod(tpz.mod.ATTP, 5 * diff)
                pet:setHP(pet:getMaxHP())
                player:messageBasic(tpz.msg.basic.STATUS_INCREASED, 0, 0, pet)
                master:addMod(tpz.mod.ATTP, 4 * diff)
                master:addMod(tpz.mod.DEFP, 4 * diff)
            end
            pet:setLocalVar("wyvern_exp", prev_exp + exp)
            pet:setLocalVar("level_Ups", pet:getLocalVar("level_Ups") + diff)
        end
    end)
end

function onMobFight(mob, target)
    local master = mob:getMaster()
    -- Add item mods
    local Learring = master:getEquipID(tpz.slot.EAR1)
    local Rearring = master:getEquipID(tpz.slot.EAR2)
    if Learring == 16000 or Rearring == 16000 then -- Dragoon's Earring
	    if mob:getMainLvl() >= 70 then
		    mob:setMod(tpz.mod.MACC, 68)
	    elseif mob:getMainLvl() >= 50 then
	        mob:setMod(tpz.mod.MACC, 55)
	    elseif mob:getMainLvl() >= 30 then
	        mob:setMod(tpz.mod.MACC, 42)
	    elseif mob:getMainLvl() >= 10 then
	        mob:setMod(tpz.mod.MACC, 20)
	    end
    else
 	    if mob:getMainLvl() >= 70 then
		    mob:setMod(tpz.mod.MACC, 48)
	    elseif mob:getMainLvl() >= 50 then
	        mob:setMod(tpz.mod.MACC, 35)
	    elseif mob:getMainLvl() >= 30 then
	        mob:setMod(tpz.mod.MACC, 22)
	    elseif mob:getMainLvl() >= 10 then
	        mob:setMod(tpz.mod.MACC, 10)
	    end       
    end
    -- Spirit power logic(Spirit Surge)
    local SpiritPower = master:getLocalVar("SpiritPower")
    if SpiritPower > 0 then
        mob:setMod(tpz.mod.ATTP, SpiritPower * 15)
    else
        mob:setMod(tpz.mod.ATTP, 0)
    end
end

function onMobDeath(mob, player)
    local master = mob:getMaster()
    local numLvls = mob:getLocalVar("level_Ups")
    if numLvls ~= 0 then
        master:delMod(tpz.mod.ATTP, 4 * numLvls)
        master:delMod(tpz.mod.DEFP, 4 * numLvls)
        master:delMod(tpz.mod.HASTE_ABILITY, 200 * numLvls)
    end
    master:removeListener("PET_WYVERN_WS")
    master:removeListener("PET_WYVERN_MAGIC")
    master:removeListener("PET_WYVERN_ENGAGE")
    master:removeListener("PET_WYVERN_DISENGAGE")
    master:removeListener("PET_WYVERN_EXP")
end
