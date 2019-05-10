-----------------------------------
-- Area: Qufim Island
--   NM: Kraken
-----------------------------------
require("scripts/globals/mobs")
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
    if player:getMainJob() == dsp.job.BLM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.THF and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.ROGUES_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.PLD and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.GALLANT_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.DRK and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.CHAOS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.BST and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.BEAST_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.SAM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.NIN and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.NINJAS_GARB_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.DRG and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.DRACHEN_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.SMN and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.BLU and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.MAGUS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.COR and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.PUP and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.DNC and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.DANCERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.SCH and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
    end
end
