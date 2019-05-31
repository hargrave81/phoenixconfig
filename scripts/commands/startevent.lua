
cmdprops =
{
    permission = 5,
    parameters = "si"
};

function onTrigger(player,target, event)
    local targ = GetPlayerByName( target );    
    targ:startEvent(event);        
end;

