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
    if player:getMainJob() == dsp.job.DRG and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.DRACHEN_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.DRACHEN_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.SMN and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.EVOKERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.COR and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.CORSAIRS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.PUP and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.PUPPETRY_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.DNC and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.DANCERS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.DANCERS_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == dsp.job.SCH and player:getMainLvl() > 45 then
        player:addKeyItem(dsp.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, dsp.ki.SCHOLARS_ATTIRE_CLAIM_SLIP);
    end
end