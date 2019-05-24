---------------------------------------------------------------------------------------------------
-- func: mh
-- desc: opens the Mog House menu anywhere in any city
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/msg")

cmdprops =
{
    permission = 0,
    parameters = "s"
};


function onTrigger(player,destination)    
    local cities = {26,32,48,50,70,71,80,87,94,189,199,214,219,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,256,257,280,284,285};
    local yourZone = player:getZoneID()
    for i, cityId in pairs(cities) do
        if (cityId == yourZone) then
            player:PrintToPlayer("Attempt to Teleport to Dest > "..destination);
            if destination == "Teleport-Yhoat" or destination == "yhoat" then
                if (target:hasKeyItem(dsp.ki.YHOATOR_GATE_CRYSTAL) == true) then
                    target:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.YHOAT,0,4.7)
                    player:PrintToPlayer("Sending you to Yhoat ...")
                    spell:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    spell:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end
            return;
        end
    end
    player:PrintToPlayer("!tele can only be used in cities");
end;

