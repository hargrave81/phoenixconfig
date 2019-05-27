require("scripts/globals/keyitems");
require("scripts/globals/status");
require("scripts/globals/titles")

cmdprops =
{
    permission = 1,
    parameters = "si"
};

function onTrigger(player,target, cp)
    
    player:PrintToPlayer("!cpthem is CP");
    local targ = GetPlayerByName( target );    
    if (cp == nil or cp == 0) then
        error(player, "Invalid amount.");
        return;
    end
    targ:PrintToPlayer("you are getting some cp added -> "..cp);
    
    -- add cp
    targ:addCP( cp );
    player:PrintToPlayer(string.format("Added %i cp to %s.", cp, targ:getName()));
end;

