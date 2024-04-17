-----------------------------------
-- Area: Bastok Mines
--  NPC: Arva
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings");
local ID = require("scripts/zones/Bastok_Mines/IDs");
require("scripts/globals/coupon");

function onTrade(player,npc,trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(4);        
    end
end;

function onTrigger(player,npc)
    player:startEvent(3);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if (csid == 4) then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:addGil(GIL_RATE*5000);
        player:tradeComplete();
    end
end;
