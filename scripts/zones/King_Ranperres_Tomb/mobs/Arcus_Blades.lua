-----------------------------------
-- Area: King Ramperres Tomb
--   NM: Acrus Blades - Theif, Paladin, Darkknight, Beastmaster, Samauri, Monk
-----------------------------------
require("scripts/globals/mobs");
require("scripts/globals/keyitems");
require("scripts/globals/status");
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:PrintToPlayer("You sense this monster is good for Thieves, Paladins, Dark Knights, Beast Masters, Samurais and Monks");
    local ID = zones[player:getZoneID()]    
    if player:getMainJob() == tpz.job.THF and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.ROGUES_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.ROGUES_ATTIRE_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.PLD and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.GALLANT_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.GALLANT_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.DRK and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.CHAOS_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.CHAOS_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.BST and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.BEAST_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.BEAST_ARMOR_CLAIM_SLIP);
    end
    if player:getMainJob() == tpz.job.MNK and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.TEMPLE_ATTIRE_CLAIM_SLIP);
    end    
    if player:getMainJob() == tpz.job.SAM and player:getMainLvl() > 45 then
        player:addKeyItem(tpz.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
        player:messageSpecial( ID.text.KEYITEM_OBTAINED, tpz.ki.MYOCHIN_ARMOR_CLAIM_SLIP);
    end    
end
