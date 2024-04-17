-----------------------------------
-- Area: RoMaeve
--   NM: Fired Urn - Dragoon, Summoner, Corsair, Puppetmaster, Dancer, Scholar
-----------------------------------
require("scripts/globals/mobs");
require("scripts/globals/keyitems");
require("scripts/globals/status");

-----------------------------------

function onMobDeath(mob, player, isKiller)  
    player:PrintToPlayer("You sense this monster is good for Dragoons, Summoners, Corsairs, Puppet Masters, Dancers and Scholars");
    local ID = zones[player:getZoneID()]
    if player:getMainJob() == xi.job.DRG and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.DRACHEN_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.DRACHEN_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.SMN and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.COR and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.PUP and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.DNC and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.DANCERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.DANCERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.SCH and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
    end
end