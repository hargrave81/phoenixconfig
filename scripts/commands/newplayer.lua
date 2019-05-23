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

    for i = dsp.ki.MAP_OF_THE_SAN_DORIA_AREA, dsp.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
        targ:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_AL_ZAHBI, dsp.ki.MAP_OF_OUTER_RAKAZNAR do
        targ:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_RALA_WATERWAYS_U, dsp.ki.MAP_OF_OUTER_RAKAZNAR_U do
        targ:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_ESCHA_ZITAH, dsp.ki.MAP_OF_REISENJIMA do
        targ:addKeyItem(i)
    end

    targ:changeContainerSize(dsp.inv.INVENTORY, 50)
    targ:changeContainerSize(dsp.inv.MOGSATCHEL, 50)
    targ:addNationTeleport(dsp.nation.SANDORIA, 2097120)
    targ:addNationTeleport(dsp.nation.BASTOK,   2097120)
    targ:addNationTeleport(dsp.nation.WINDURST, 2097120)
    
    targ:setGil(player:getGil() + 1000)    

    targ:addItem(536) -- adventurer coupon
    targ:addTitle(dsp.title.NEW_ADVENTURER)
    targ:setNewPlayer(true) -- apply new player flag
end;

