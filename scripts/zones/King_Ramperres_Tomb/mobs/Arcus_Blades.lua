-----------------------------------
-- Area: King Ramperres Tomb
--   NM: Acrus Blades - Theif, Paladin, Darkknight, Beastmaster, Samauri, Monk
-----------------------------------
require("scripts/globals/mobs");
require("scripts/globals/keyitems");
require("scripts/globals/status");
-----------------------------------

function onMobDeath(mob, player, isKiller)
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
    if player:getMainJob() == dsp.job.MNK and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == dsp.job.SAM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
    end    
end
