-----------------------------------
-- Area: Bastok Markets
--  NPC: Specilox
-- Gift NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
require("scripts/globals/status")

function onTrade(player,npc,trade)
    
end;

function onTrigger(player,npc)
    local stock =
    {
        4128, 4445,    -- Ether
        4151,  736,    -- Echo Drops
        1179,   65,    -- Shihei
        4381, 1500,    -- meat mithkabobs
        5149, 4500,    -- sole sushi
        4414, 1500,    -- rolanberry Pie        
        17340,  60,    -- bullet
        17318,  20,    -- wooden arrow        
    }
    local giftReady = vanaDay() > player:getVar("LastGoblinGift")
    if giftReady then        
        -- randomly give a gift
        local gift = 4120;
        local max = {26, 21,23};
        local gearA = 
        {
            17271, -- platoon gun
            17786, -- ganko
            17571, -- platoon pole
            17692, -- platoon spatha
            17820, -- gunromaru
            18170, -- platoon edge
            18171, -- platoon disc
            18209, -- platoon cutter
            18085, -- platoon lance
            17993, -- platoon dagger
            16959, -- platoon sword
            16687, -- platoon axe
            18045, -- platoon zaghnal
            17519, -- platoon cesti
            17462, -- platoon mace
            17202, -- platoon bow
            13251, -- ocean belt
            13252, -- forest belt
            13253, -- steppe belt
            13254, -- jungle belt
            13255, -- desert belt
            13256, -- ocean stone
            13257, -- forest stone
            13258, -- steppe stone
            13259, -- jungle stone
            13260, -- desert stone
        };
        local gearB = 
        {
            4869, -- warp
            4853, -- drain
            4898, -- air spirit pact
            4947, -- utsusemi: ni
            4751, -- erase
            4868, -- dispel
            5070, -- magic finale
            4714, -- phalanx
            4621, -- raise 2
            4749, -- reraise 2
            836, -- damascene cloth
            13549, -- ether ring 
            13404, -- nemesis earring
            14655, -- venerer ring
            11043, -- giants earring
            13435, -- mercen earring
            12486, -- emperor hairpin
            14650, -- marksman's ring
            13164, -- agile gorget
            12350, -- strike shield
            13553, -- blitz ring
        };
        local gearC = 
        {
            4900, -- thunder spirit pact
            13548, -- astral ring
            4902, -- light spirit pact
            13403, -- assault earring
            16788, -- vassago's scyth
            1255, -- fire ore
            1256, -- ice ore
            1257, -- wind ore
            1258, -- earth ore
            1259, -- lightning ore
            1260, -- water ore
            1261, -- light ore
            1262, -- dark ore
            17788, -- sairen
            17648, -- dragvandil
            17647, -- aramis's rapier
            18087, -- schwarz lance
            17491, -- spartan cesti
            17379, -- hamelin flute
            17235, -- armbrust
            16684, -- kabrakan's axe
            17822, -- omokage
            18632, -- iridal staff
        };
        local tarum = 14837;
        local taruf = 14838;
        local mith = 14839;
        local galk = 14840;
        local elvf = 14836;
        local elvm = 14835;
        local humf = 14834;
        local humm = 14833;

        local factor1 = math.random(1,100);
        local factor2 = 0;
        if factor1 > 98 then 
            factor2 = 2;
        elseif factor1 > 93 then
            factor2 = 3;
        elseif factor1 > 82 then
            factor2 = 1;
        end
        player:PrintToPlayer("Rolling Dice  1="..factor1.."  2="..factor2);
        if factor2 == 3 then
            if player:getRace() == dsp.race.MITHRA then
                gift = mith;
            elseif player:getRace() == dsp.race.TARU_M then
                gift = tarum;
            elseif player:getRace() == dsp.race.TARU_F then
                gift = taruf;
            elseif player:getRace() == dsp.race.ELVAAN_M then
                gift = elvm;
            elseif player:getRace() == dsp.race.ELVAAN_F then
                gift = elvf;
            elseif player:getRace() == dsp.race.HUME_M then
                gift = humm;
            elseif player:getRace() == dsp.race.HUME_F then
                gift = humf;
            elseif player:getRace() == dsp.race.GALKA then            
                gift = galk;
            end
        else
            if factor2 ~= nil then
                local factor3 = math.random(0,max[factor2]-1);
                if factor2 == 0 then
                    gift = gearA[factor3];
                elseif factor2 == 1 then
                    gift = gearB[factor3];
                else
                    gift = gearC[factor3];
                end
            end
        end
        player.addItem(gift);
        player:messageSpecial(ID.text.ITEM_OBTAINED, gift);
        player:setVar("LastGoblinGift",vanaDay())
    end    
    player:showText(npc,ID.text.OLWYN_SHOP_DIALOG)
    dsp.shop.nation(player, stock, dsp.nation.BASTOK)
end