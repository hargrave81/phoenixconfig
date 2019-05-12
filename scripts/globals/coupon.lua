-- Starting items from adv. Coupon

function onCoupon(player,msgId)    
    player:addItem(16144);        
    player:messageSpecial(msgId, 16144); -- sol cap
    player:addItem(14657);
    player:messageSpecial(msgId, 14657); -- dcl.grd. ring
    player:addItem(14653);
    player:messageSpecial(msgId, 14653); -- var. ring
    player:addItem(13680);
    player:messageSpecial(msgId, 13680); -- var. mantle
    player:addItem(13681);
    player:messageSpecial(msgId, 13681); -- var. cape
end