-----------------------------------
-- Area: Windurst Waters
--  NPC: Jack of Hearts
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings");
require("scripts/globals/coupon");
local ID = require("scripts/zones/Windurst_Waters/IDs");

function onTrade(player,npc,trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(10012,GIL_RATE*5000);        
    end
end;

function onTrigger(player,npc)
    player:startEvent(10011,0,1);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if csid == 10012 then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:addGil(GIL_RATE*5000);
        player:tradeComplete();
    end
end;
