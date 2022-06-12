---------------------------------------------------------------------------------------------------
-- func: mh
-- desc: opens the Mog House menu anywhere in any city
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")


cmdprops =
{
    permission = 0,
    parameters = ""
};


function onTrigger(player)
    local cities = {26,32,48,50,70,71,80,87,94,189,199,214,219,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,256,257,280,284,285};
    local yourZone = player:getZoneID()
    for i, cityId in pairs(cities) do
        if (cityId == yourZone) then
            player:sendMenu(1)
            return;
        end
    end
    player:PrintToPlayer("!mh can only be used in cities");    
end;

