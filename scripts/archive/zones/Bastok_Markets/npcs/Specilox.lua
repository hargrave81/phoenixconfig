-----------------------------------
-- Area: Bastok Markets
--  NPC: Specilox
-- Gift NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
require("scripts/globals/status")

function onTrade(player,npc,trade)
    
end;

function onTrigger(player,npc)
    local stock =
    {
        4128, 4445,    -- Ether
        4151,  736,    -- Echo Drops
        1179,   65,    -- Shihei
        4381, 1500,    -- meat mithkabobs
        5149, 4500,    -- sole sushi
        4414, 1500,    -- rolanberry Pie        
        17340,  60,    -- bullet
        17318,  20,    -- wooden arrow        
    }
    local giftReady = vanaDay() > player:getCharVar("LastGoblinGift")
    
    player:PrintToPlayer("Rolling Dice  gift"..giftReady)
    player:showText(npc,ID.text.OLWYN_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
