---------------------------------------------------------------------------------------------------
-- func: ah
-- desc: opens the Auction House menu anywhere in the world
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")


cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    if player:getZone():GetType() == dsp.zoneType.CITY then player:sendMenu(1) end;
end;