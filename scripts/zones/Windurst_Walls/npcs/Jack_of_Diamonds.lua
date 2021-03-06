-----------------------------------
-- Area: Windurst Walls
--  NPC: Jack of Diamonds
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings");
require("scripts/globals/coupon");
local ID = require("scripts/zones/Windurst_Walls/IDs");

function onTrade(player,npc,trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(10002,GIL_RATE*5000);        
    end
end;

function onTrigger(player,npc)
    player:startEvent(10001,0,2);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if csid == 10002 then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:addGil(GIL_RATE*5000);
        player:tradeComplete();
    end
end;
