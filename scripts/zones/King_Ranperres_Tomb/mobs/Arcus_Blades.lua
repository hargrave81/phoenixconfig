-----------------------------------
-- Area: King Ramperres Tomb
--   NM: Acrus Blades - Theif, Paladin, Darkknight, Beastmaster, Samauri, Monk
-----------------------------------
require("scripts/globals/mobs");
require("scripts/globals/keyitems");
require("scripts/globals/status");
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:PrintToPlayer("You sense this monster is good for Thieves, Paladins, Dark Knights, Beast Masters, Samurais and Monks");
    local ID = zones[player:getZoneID()]    
    if player:getMainJob() == xi.job.THF and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.ROGUES_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.ROGUES_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.PLD and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.GALLANT_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.GALLANT_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.DRK and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.CHAOS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.CHAOS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.BST and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.BEAST_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.BEAST_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == xi.job.MNK and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == xi.job.SAM and player:getMainLvl() > 45 then
        player:addKeyItem(xi.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, xi.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
    end    
end
