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
    if player:getMainJob() == tpz.job.WAR and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.FIGHTERS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.FIGHTERS_ARMOR_CLAIM_SLIP );
    end
    if player:getMainJob() == tpz.job.WHM and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.HEALERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.HEALERS_ATTIRE_CLAIM_SLIP );
    end
    if player:getMainJob() == tpz.job.RDM and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.BRD and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.CHORAL_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.CHORAL_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.RNG and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.BLM and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
    end        
    if player:getMainJob() == tpz.job.BLU and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.MAGUS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.MAGUS_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == tpz.job.NIN and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.NINJAS_GARB_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.NINJAS_GARB_CLAIM_SLIP);
    end
end
