-----------------------------------
-- Area: Castle Zvahl Bailys
--   NM: Flame of Fate - Warrior, White Mage, Blue Mage, Red Mage, Bard, Ranger, Black Mage, Ninja
-----------------------------------
require("scripts/globals/mobs");
require("scripts/globals/keyitems");
require("scripts/globals/status");

-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:PrintToPlayer("You sense this monster is good for Warriors, Bards, Rangers, Ninjas and White/Blue/Red/Black Mages");
    local ID = zones[player:getZoneID()]    
    if player:getMainJob() == dsp.job.WAR and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.FIGHTERS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.FIGHTERS_ARMOR_CLAIM_SLIP );
    end
    if player:getMainJob() == dsp.job.WHM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.HEALERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.HEALERS_ATTIRE_CLAIM_SLIP );
    end
    if player:getMainJob() == dsp.job.RDM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.BRD and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.CHORAL_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.CHORAL_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.RNG and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.BLM and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
    end        
    if player:getMainJob() == dsp.job.BLU and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.MAGUS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.MAGUS_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == dsp.job.NIN and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.NINJAS_GARB_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.NINJAS_GARB_CLAIM_SLIP);
    end
end
