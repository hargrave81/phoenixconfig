-- Starting items from adv. Coupon

function onCoupon(player,msgId)    
    if (player:hasItem(16144) == false) then
        player:addItem(16144);        
        player:messageSpecial(msgId, 16144); -- sol cap
    end
    if (player:hasItem(14657) == false) then
        player:addItem(14657);
        player:messageSpecial(msgId, 14657); -- dcl.grd. ring
    end
    if (player:hasItem(16279) == false) then
        player:addItem(16279);
        player:messageSpecial(msgId, 16279); -- pile chain
    end
    if (player:hasItem(18166) == false) then
        player:addItem(18166);
        player:messageSpecial(msgId, 18166); -- happy egg
    end
    if (player:hasItem(15198) == false) then
        player:addItem(15198);    
        player:messageSpecial(msgId, 15198); -- sprout beret
        player:addGil(15000);
    end    
    if player:hasKeyItem(3073) ~= true then
        player:addKeyItem(3073)
        player:PrintToPlayer("Received a mount! Go Riding!")
    end
end