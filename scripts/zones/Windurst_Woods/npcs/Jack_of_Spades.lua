-----------------------------------
-- Area: Windurst Woods
--  NPC: Jack of Spades
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/coupon");
local ID = require("scripts/zones/Windurst_Woods/IDs");
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 536) then -- adventurer coupon
        player:startEvent(10010, GIL_RATE * 50)
    end
end

function onTrigger(player,npc)
    player:startEvent(10009,0,4)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 10010 then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:addGil(GIL_RATE*5000);
        player:tradeComplete();
    end
end