-----------------------------------
-- Area: Port San d'Oria
--  NPC: Teilsa
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scrited
-- This NPC participates in Quests and Missions
-------------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs");
require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/coupon");
-------------------------------------

function onTrade(player,npc,trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536,1) == true) then
        player:startEvent(612);        
    end
    -- "Flyers for Regine" conditional script
    local count = trade:getItemCount();
    local MagicFlyer = trade:hasItemQty(532,1);

    if (MagicFlyer == true and count == 1) then
        local FlyerForRegine = player:getQuestStatus(SANDORIA,xi.quest.id.sandoria.FLYERS_FOR_REGINE);
        if (FlyerForRegine == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED);
        end
    end
end;

function onTrigger(player,npc)
    player:startEvent(573);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if (csid == 612) then
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*5000);
        onCoupon(player,ID.text.ITEM_OBTAINED);
        player:addGil(GIL_RATE*5000);
        player:tradeComplete();
    end
end;
