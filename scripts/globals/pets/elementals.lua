-----------------------------------
--  PET: Elementals
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")

function castSpell(player, threshold, breath)
    
end

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(dsp.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), dsp.job.SMN, dsp.skill.SUMMONING_MAGIC)
    return math.max(summoningSkill - maxSkill, 0)
end

function onMobSpawn(mob)
    local master = mob:getMaster()
    if (mob:getFamily() == 11) then
        mob:addMod(dsp.mod.FAST_CAST, -400)
    end if
end

function onMobDeath(mob, player)
    mob:removeListener("PET_ELEMENT_ENGAGE")
end

mob:addListener("ATTACK", "PET_ELEMENT_ENGAGE", function(mob, target, action)
    if (mob:getFamily() == 11) then
        local master = mob:getMaster()
        local smnSkill = getSummoningSkillOverCap(mob)
        -- decide if we are going to cast on start or not
        if(smnSkill > 0) then
            -- we have a chance to cast on engage
            if(math.random(0,99) > 25) then
                -- for now just claim the shadows were absorbed until we figure out how to abort
                action:messageID(mob:getID(), dsp.msg.basic.MAGIC_UNABLE_TO_CAST)                
            end
        end
    end
end)