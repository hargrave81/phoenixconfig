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

    for i = tpz.ki.MAP_OF_THE_SAN_DORIA_AREA, tpz.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
        targ:addKeyItem(i)
    end
    for i = tpz.ki.MAP_OF_AL_ZAHBI, tpz.ki.MAP_OF_OUTER_RAKAZNAR do
        targ:addKeyItem(i)
    end
    for i = tpz.ki.MAP_OF_RALA_WATERWAYS_U, tpz.ki.MAP_OF_OUTER_RAKAZNAR_U do
        targ:addKeyItem(i)
    end
    for i = tpz.ki.MAP_OF_ESCHA_ZITAH, tpz.ki.MAP_OF_REISENJIMA do
        targ:addKeyItem(i)
    end

    targ:changeContainerSize(tpz.inv.INVENTORY, 50)
    targ:changeContainerSize(tpz.inv.MOGSATCHEL, 50)
    targ:addNationTeleport(tpz.nation.SANDORIA, 2097120)
    targ:addNationTeleport(tpz.nation.BASTOK,   2097120)
    targ:addNationTeleport(tpz.nation.WINDURST, 2097120)
    
    targ:setGil(player:getGil() + 1000)    

    targ:addItem(536) -- adventurer coupon
    targ:addTitle(tpz.title.NEW_ADVENTURER)
    targ:setNewPlayer(true) -- apply new player flag
end;

