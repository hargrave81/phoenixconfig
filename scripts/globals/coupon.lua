-- Starting items from adv. Coupon

function onCoupon(player,msgId)    
    player:addItem(16144);        
    player:messageSpecial(msgId, 16144); -- sol cap
    player:addItem(14657);
    player:messageSpecial(msgId, 14657); -- dcl.grd. ring
    player:addItem(14653);
    player:messageSpecial(msgId, 16279); -- pile chain
    player:addItem(13680);
    player:messageSpecial(msgId, 18166); -- happy egg
    player:addItem(13681);
    player:messageSpecial(msgId, 15198); -- sprout beret
    player:addGil(15000);
end