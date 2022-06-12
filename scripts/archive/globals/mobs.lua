-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------

dsp = dsp or {}
xi.mob = xi.mob or {}

function onMobFightEx(mob, player)
    -- oportunity to reduce any resistance that was built up

end

-- onMobDeathEx is called from the core
function onMobDeathEx(mob, player, isKiller, isWeaponSkillKill)
    -- Things that happen only to the person who landed killing blow
    if isKiller then
        -- DRK quest - Blade Of Darkness
        if
            (player:getQuestStatus(BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or player:getQuestStatus(BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
            player:getEquipID(xi.slot.MAIN) == 16607 and
            player:getCharVar("ChaosbringerKills") < 200 and
            not isWeaponSkillKill
        then
            player:addCharVar("ChaosbringerKills", 1)
        end
    end

    -- Things that happen to any player in the party/alliance
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.A_TESTING_TIME then
        if
            (player:getZoneID() == xi.zone.BUBURIMU_PENINSULA and player:hasCompletedMission(WINDURST, xi.mission.id.windurst.A_TESTING_TIME)) or
            (player:getZoneID() == xi.zone.TAHRONGI_CANYON and not player:hasCompletedMission(WINDURST, xi.mission.id.windurst.A_TESTING_TIME))
        then
            player:addCharVar("testingTime_crea_count", 1)
        end
    end
    --[[
    -- detect mob chain
    local mobChainFam = player:getCharVar("MobChainFamily")
    local mobChainCt = player:getCharVar("MobChainCount")
    if mob:getSystem() == mobChainFam then
        mobChainCt = mobChainCt + 1
        player:setCharVar("MobChainCount", mobChainCt)
    else
        if mobChainCt > 5 then
            player:PrintToPlayer("You sense that you've lost the elemental advantage.")
        end
        mobChainCt = 1
        player:setCharVar("MobChainCount", mobChainCt)
        player:setCharVar("MobChainFamily", mob:getSystem())                
    end
    if mobChainCt > 5 then
        if math.random(1,4) > 1 then
            local chest = false
            local bonus = {9,11,12,16,18,20,22,27,28,29,30,62,65,72,92,96,99,131,138,140,141,142,143,145,147,148,149,150,151,153,155,157,159,160,161,162,164,166,167,169,171,172,173,174,175,176,184,190,191,192,193,194,195,196,197,198,200,204,205,208,212,213,258,268,269,270,272,273,274};
            local bonus2 = {1,2,3,4,5,7,15,24,25,33,43,44,45,46,47,51,52,53,54,58,59,61,79,81,82,83,84,85,88,89,90,91,95,97,98,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,130,132,136,137,215,216,217,218,223,224,225,226,227,228,253,254,255,260,261,262,263,265,266,267,288,289};
            local yourZone = player:getZoneID()
            for i, cityId in pairs(bonus2) do
                if (cityId == yourZone) then
                    chest = true
                    break
                end
            end    
            if chest == false then
                local yourZone = player:getZoneID()
                for i, cityId in pairs(bonus) do
                    if (cityId == yourZone) then
                        if math.random(1,4) > 1 then -- less likely in dungeons
                            chest = true
                        end
                        break
                    end
                end    
            end
            if chest then
                local chainLevel = mobChainCt / 5
                local power = math.floor(chainLevel * 8)
                if power > 70 then 
                    power = 70            
                end      
                local magicUser = false
                if player:getMainJob() == xi.job.WHM or player:getMainJob() == xi.job.BLM or player:getMainJob() == xi.job.SCH or player:getMainJob() == xi.job.DRK or player:getMainJob() == xi.job.PLD or player:getMainJob() == xi.job.BLU then
                    magicUser = true
                end
                local buffs1=  {88,89,33}  -- * 12 (HP, MP, HASTE)
                local buffs2 = {43,42,288} -- half power (refresh regen)
                local buffs3 = {90,91,93,154,219,555,551} -- double power (acc, atk, eva,def,macc,matk)                
                local buffs4 = {219,40,41} -- triple power (ruby, protect, shell)
                local buffs5 = {80,81,82,83,84,85,86,90,92,190,191,799} -- bunch of mods                
                player:PrintToPlayer("The death of the monster exposed elemental powers that have strengthened you!")
                local page = math.random(1,12)
                if page == 1 or page == 2 or page == 3 then
                    player:addStatusEffect(buffs1[math.random(1,3)], power * 12, 0, 800)
                end
                if page == 4 or page == 5 or page == 6 then
                    player:addStatusEffect(buffs2[math.random(1,2)], math.floor(power / 2), 0, 800)
                end
                if page == 7 or page == 8 or page == 9 then
                    player:addStatusEffect(buffs3[math.random(1,7)], power * 2, 0, 800)
                end
                if page == 3 or page == 6 or page >= 9 then                                
                    player:addStatusEffect(buffs5[math.random(1,13)], power, 0, 800)
                end
                if page == 2 or page == 5 or page == 8 then
                    player:addStatusEffect(buffs4[math.random(1,3)], power * 3, 0, 800)
                end
                
                if player:getPet() then
                    if page == 1 or page == 2 or page == 3 then
                        player:getPet():addStatusEffect(buffs1[math.random(1,3)], power * 12, 0, 800)
                    end
                    if page == 4 or page == 5 or page == 6 then
                        player:getPet():addStatusEffect(buffs2[math.random(1,2)], math.floor(power / 2), 0, 800)
                    end
                    if page == 7 or page == 8 or page == 9 then
                        player:getPet():addStatusEffect(buffs3[math.random(1,7)], power*2, 0, 800)
                    end
                    if page == 3 or page == 6 or page >= 9 then     
                        player:getPet():addStatusEffect(buffs5[math.random(1,13)], power, 0, 800)                           
                    end
                    if page == 2 or page == 5 or page == 8 then
                        player:getPet():addStatusEffect(buffs4[math.random(1,3)], power * 3, 0, 800)
                    end 
                end
            end
        end
    end
    ]]--
end

-------------------------------------------------
-- placeholder / lottery NMs
-------------------------------------------------

-- is a lottery NM already spawned or primed to pop?
local function lotteryPrimed(phList)
    local nm
    for k, v in pairs(phList) do
        nm = GetMobByID(v)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end
    return false
end

-- potential lottery placeholder was killed
xi.mob.phOnDespawn = function(ph, phList, chance, cooldown, immediate)
    if type(immediate) ~= "boolean" then immediate = false end

    local phId = ph:getID()
    local nmId = phList[phId]

    if nmId ~= nil then
        local nm = GetMobByID(nmId)
        if nm ~= nil then
            local pop = nm:getLocalVar("pop")

            if os.time() > pop and not lotteryPrimed(phList) and math.random(100) <= chance then

                -- on PH death, replace PH repop with NM repop
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(immediate and 1 or GetMobRespawnTime(phId)) -- if immediate is true, spawn the nm immediately (1ms) else use placeholder's timer

                nm:addListener("DESPAWN", "DESPAWN_" .. nmId, function(m)
                    -- on NM death, replace NM repop with PH repop
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:setLocalVar("pop", os.time() + cooldown)
                    m:removeListener("DESPAWN_" .. nmId)
                end)

                return true
            end
        end
    end

    return false
end

-------------------------------------------------
-- mob additional melee effects
-------------------------------------------------

xi.mob.additionalEffect =
{
    BLIND      = 0,
    CURSE      = 1,
    ENAERO     = 2,
    ENBLIZZARD = 3,
    ENDARK     = 4,
    ENFIRE     = 5,
    ENLIGHT    = 6,
    ENSTONE    = 7,
    ENTHUNDER  = 8,
    ENWATER    = 9,
    EVA_DOWN   = 10,
    HP_DRAIN   = 11,
    MP_DRAIN   = 12,
    PARALYZE   = 13,
    PETRIFY    = 14,
    PLAGUE     = 15,
    POISON     = 16,
    SILENCE    = 17,
    SLOW       = 18,
    STUN       = 19,
    TERROR     = 20,
    TP_DRAIN   = 21,
}
xi.mob.ae = xi.mob.additionalEffect

local additionalEffects =
{
    [xi.mob.ae.BLIND] =
    {
        chance = 25,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.BLIND,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.BLINDNESS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.CURSE] =
    {
        chance = 20,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.CURSE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.CURSE_I,
        power = 50,
        duration = 300,
        minDuration = 1,
        maxDuration = 300,
    },
    [xi.mob.ae.ENAERO] =
    {
        ele = xi.magic.ele.WIND,
        sub = xi.subEffect.WIND_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENBLIZZARD] =
    {
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.ICE_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENDARK] =
    {
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.DARKNESS_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENFIRE] =
    {
        ele = xi.magic.ele.FIRE,
        sub = xi.subEffect.FIRE_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENLIGHT] =
    {
        ele = xi.magic.ele.LIGHT,
        sub = xi.subEffect.LIGHT_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENSTONE] =
    {
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.EARTH_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENTHUNDER] =
    {
        ele = xi.magic.ele.LIGHTNING,
        sub = xi.subEffect.LIGHTNING_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENWATER] =
    {
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.WATER_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.EVA_DOWN] =
    {
        chance = 25,
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.EVASION_DOWN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.EVASION_DOWN,
        power = 25,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.HP_DRAIN] =
    {
        chance = 10,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.HP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) mob:addHP(power) end,
    },
    [xi.mob.ae.MP_DRAIN] =
    {
        chance = 10,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.MP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local mp = math.min(power, target:getMP()) target:delMP(mp) mob:addMP(mp) end,
    },
    [xi.mob.ae.PARALYZE] =
    {
        chance = 25,
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.PARALYSIS,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PARALYSIS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.PETRIFY] =
    {
        chance = 20,
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.PETRIFY,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PETRIFICATION,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.PLAGUE] =
    {
        chance = 25,
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.PLAGUE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PLAGUE,
        power = 1,
        duration = 60,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.POISON] =
    {
        chance = 25,
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.POISON,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.POISON,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
    },
    [xi.mob.ae.SILENCE] =
    {
        chance = 25,
        ele = xi.magic.ele.WIND,
        sub = xi.subEffect.SILENCE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.SILENCE,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [xi.mob.ae.SLOW] =
    {
        chance = 25,
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.DEFENSE_DOWN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.SLOW,
        power = 1000,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.STUN] =
    {
        chance = 20,
        ele = xi.magic.ele.LIGHTNING,
        sub = xi.subEffect.STUN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.STUN,
        duration = 5,
    },
    [xi.mob.ae.TERROR] =
    {
        chance = 20,
        sub = xi.subEffect.PARALYSIS,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.TERROR,
        duration = 5,
        code = function(mob, target, power) mob:resetEnmity(target) end,
    },
    [xi.mob.ae.TP_DRAIN] =
    {
        chance = 25,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.TP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local tp = math.min(power, target:getTP()) target:delTP(tp) mob:addTP(tp) end,
    },
}

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type xi.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
xi.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= "table" then params = {} end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100
        local dLevel = target:getMainLvl() - mob:getMainLvl()

        if dLevel > 0 then
            chance = chance - 5 * dLevel
            chance = utils.clamp(chance, 5, 95)
        end

        -- target:PrintToPlayer(string.format("Chance: %i", chance)) -- DEBUG

        if math.random(100) <= chance then

            -- STATUS EFFECT
            if ae.applyEffect then
                local resist = 1
                if ae.ele then
                    resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
                end

                if resist > 0.5 and not target:hasStatusEffect(ae.eff) then
                    local power = params.power or ae.power or 0
                    local tick = ae.tick or 0
                    local duration = params.duration or ae.duration

                    if dLevel < 0 then
                        duration = duration - dLevel
                    end

                    if ae.minDuration and duration < ae.minDuration then
                        duration = ae.minDuration
                    elseif ae.maxDuration and duration > ae.maxDuration then
                        duration = ae.maxDuration
                    end

                    duration = duration * resist

                    target:addStatusEffect(ae.eff, power, tick, duration)

                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, ae.msg, ae.eff
                end

            -- IMMEDIATE EFFECT
            else
                local power = 0

                if params.power then
                    power = params.power
                elseif ae.mod then
                    local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

                    if dMod > 20 then
                        dMod = 20 + (dMod - 20) / 2
                    end

                    power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
                end

                -- target:PrintToPlayer(string.format("Initial Power: %f", power)) -- DEBUG

                power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
                power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
                power = adjustForTarget(target, power, ae.ele)
                power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)

                -- target:PrintToPlayer(string.format("Adjusted Power: %f", power)) -- DEBUG

                local message = ae.msg
                if power < 0 then
                    if ae.negMsg then
                        message = ae.negMsg
                    else
                        power = 0
                    end
                end

                if power ~= 0 then
                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, message, power
                end
            end
        end
    else
        printf("invalid additional effect for mobId %i", mob:getID())
    end

    return 0, 0, 0
end