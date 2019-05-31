-----------------------------------
-- Area: Lower Jeuno
--  NPC: Matoaka
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local stock =
    {
        14394, 50000,    -- Goldsmith Apron
        15446, 10000,    -- Goldsmith Belt
        15821, 25000,    -- Goldsmith Ring     
        13945, 40000,       -- shade specs  

        14393, 50000,    -- blacksmith Apron
        15445, 10000,    -- blacksmith Belt
        15820, 25000,    -- blacksmith Ring       
        14831, 40000,    -- smithy mitts

        14392, 50000,    -- carpenter Apron
        15444, 10000,    -- carpenter Belt
        15819, 25000,    -- carpenter Ring       
        14830, 40000,    -- carpenter gloves

        14395, 50000,    -- weaver Apron
        15447, 10000,    -- weaver Belt
        15822, 25000,    -- weaver Ring       
        13946, 40000,    -- magnifying Spectacles

        14396, 50000,    -- tanner Apron
        15448, 10000,    -- tanner Belt
        15823, 25000,    -- tanner Ring       
        14832, 40000,    -- tanner gloves     

        14397, 50000,    -- boneworker Apron
        15449, 10000,    -- boneworker Belt
        15824, 25000,    -- boneworker Ring       
        13947, 40000,    -- protective spectacles

        14398, 50000,    -- alchemist Apron
        15450, 10000,    -- alchemist Belt
        15825, 25000,    -- alchemist Ring       
        17058, 40000,    -- caduceus

        14399, 50000,    -- culinarian Apron
        15451, 10000,    -- culinarian Belt
        15826, 25000,    -- culinarian Ring   
        13948, 40000,       -- chefs hat    

    }

    player:showText(npc, ID.text.MATOAKA_SHOP_DIALOG)
    dsp.shop.general(player, stock)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
