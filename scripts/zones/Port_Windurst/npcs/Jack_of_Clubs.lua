-----------------------------------
-- Area: Port Windurst
--  NPC: Jack of Clubs
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings");
require("scripts/globals/coupon");

function onTrade(player,npc,trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(10008,GIL_RATE*5000);
        player:addGil(GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:tradeComplete();
    end
end;

function onTrigger(player,npc)
    player:startEvent(10007,0,3);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
