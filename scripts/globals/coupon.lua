-- Starting items from adv. Coupon

function onCoupon(player)    
    player:addItem(16144);        
    player:messageSpecial(text.ITEM_OBTAINED, 16144); -- sol cap
    player:addItem(14657);
    player:messageSpecial(text.ITEM_OBTAINED, 14657); -- dcl.grd. ring
    player:addItem(14653);
    player:messageSpecial(text.ITEM_OBTAINED, 14653); -- var. ring
    player:addItem(13680);
    player:messageSpecial(text.ITEM_OBTAINED, 13680); -- var. mantle
    player:addItem(13681);
    player:messageSpecial(text.ITEM_OBTAINED, 13681); -- var. cape
end