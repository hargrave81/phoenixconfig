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
    if player:getMainJob() == xi.job.WAR and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.FIGHTERS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.FIGHTERS_ARMOR_CLAIM_SLIP );
    end
    if player:getMainJob() == xi.job.WHM and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.HEALERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.HEALERS_ATTIRE_CLAIM_SLIP );
    end
    if player:getMainJob() == xi.job.RDM and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.WARLOCKS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.BRD and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.CHORAL_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.CHORAL_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.RNG and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.HUNTERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.BLM and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.WIZARDS_ATTIRE_CLAIM_SLIP);
    end        
    if player:getMainJob() == xi.job.BLU and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.MAGUS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.MAGUS_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == xi.job.NIN and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.NINJAS_GARB_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.NINJAS_GARB_CLAIM_SLIP);
    end
end
