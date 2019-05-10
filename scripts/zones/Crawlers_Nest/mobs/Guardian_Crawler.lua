-----------------------------------
-- Area: Crawlers' Nest
--  MOB: Guardian Crawler
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getMainJob() == dsp.job.WAR and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.FIGHTERS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.WHM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.HEALERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.MNK and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.RDM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.BRD and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.CHORAL_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.RNG and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
    end
end;