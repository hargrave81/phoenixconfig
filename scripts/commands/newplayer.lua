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
    target:PrintToPlayer("you are getting maps and stuff!");

    for i = dsp.ki.MAP_OF_THE_SAN_DORIA_AREA, dsp.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
        target:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_AL_ZAHBI, dsp.ki.MAP_OF_OUTER_RAKAZNAR do
        target:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_RALA_WATERWAYS_U, dsp.ki.MAP_OF_OUTER_RAKAZNAR_U do
        target:addKeyItem(i)
    end
    for i = dsp.ki.MAP_OF_ESCHA_ZITAH, dsp.ki.MAP_OF_REISENJIMA do
        target:addKeyItem(i)
    end

    target:changeContainerSize(dsp.inv.INVENTORY, 50)
    target:changeContainerSize(dsp.inv.MOGSATCHEL, 50)
    target:addNationTeleport(dsp.nation.SANDORIA, 2097120)
    target:addNationTeleport(dsp.nation.BASTOK,   2097120)
    target:addNationTeleport(dsp.nation.WINDURST, 2097120)
    
    target:setGil(player:getGil() + 1000)    

    target:addItem(536) -- adventurer coupon
    target:addTitle(dsp.title.NEW_ADVENTURER)
    target:setNewPlayer(true) -- apply new player flag
end;

