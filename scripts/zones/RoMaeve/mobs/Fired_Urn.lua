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
    if player:getMainJob() == tpz.job.DRG and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.DRACHEN_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.DRACHEN_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.SMN and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.COR and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.PUP and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.DNC and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.DANCERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.DANCERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.SCH and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
    end
end