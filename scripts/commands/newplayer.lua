require("scripts/globals/keyitems");
require("scripts/globals/status");
require("scripts/globals/titles")

cmdprops =
{
    permission = 1,
    parameters = "s"
};

function onTrigger(player,target)
    
    player:PrintToPlayer("!newplayer is adding stuff to a player");
    local targ = GetPlayerByName( target );
    targ:PrintToPlayer("you are getting maps and stuff!");

    for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
        targ:addKeyItem(i)
    end
    for i = xi.ki.MAP_OF_AL_ZAHBI, xi.ki.MAP_OF_OUTER_RAKAZNAR do
        targ:addKeyItem(i)
    end
    for i = xi.ki.MAP_OF_RALA_WATERWAYS_U, xi.ki.MAP_OF_OUTER_RAKAZNAR_U do
        targ:addKeyItem(i)
    end
    for i = xi.ki.MAP_OF_ESCHA_ZITAH, xi.ki.MAP_OF_REISENJIMA do
        targ:addKeyItem(i)
    end

    targ:changeContainerSize(xi.inv.INVENTORY, 50)
    targ:changeContainerSize(xi.inv.MOGSATCHEL, 50)
    targ:addNationTeleport(xi.nation.SANDORIA, 2097120)
    targ:addNationTeleport(xi.nation.BASTOK,   2097120)
    targ:addNationTeleport(xi.nation.WINDURST, 2097120)
    
    targ:setGil(player:getGil() + 1000)    

    targ:addItem(536) -- adventurer coupon
    targ:addTitle(xi.title.NEW_ADVENTURER)
    targ:setNewPlayer(true) -- apply new player flag
end;

