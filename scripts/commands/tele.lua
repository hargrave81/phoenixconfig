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
    parameters = "b"
};


function getBytePos(s,needle)
    local i;
    local b;
    for i=1,string.len(s),1 do
        if (string.byte(s, i) == needle) then
            return i;
        end
    end
    return nil;
end;

function onTrigger(player,destination)    
    local cities = {26,32,48,50,70,71,80,87,94,189,199,214,219,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,256,257,280,284,285};
    local yourZone = player:getZoneID()
    for i, cityId in pairs(cities) do
        if (cityId == yourZone) then
            local bytes = string.sub(destination,6);
            local destbyte1 = getBytePos(destination, 6);
            local destbyte2 = getBytePos(destination, 0);
            local destbyte3 = getBytePos(destination, 1);
            local destbyte4 = getBytePos(destination, 2);
            local destbyte5 = getBytePos(destination, 3);
            local destbyte6 = getBytePos(destination, 4);
            local destbyte7 = getBytePos(destination, 9);
            local destbyte8 = getBytePos(destination, 10);
            local destbyte9 = getBytePos(destination, 11);
            local destbyte10 = getBytePos(destination, 12);
            local deststr = tostring(bytes);
            player:PrintToPlayer("Attempt to Teleport to Dest > "..destination);
            --player:PrintToPlayer("Attempt to Teleport to Dests > "..deststr);
            player:PrintToPlayer("Attempt to Teleport to Destb > "..destbyte1.." . "..destbyte2.." . "..destbyte3.." . "..destbyte4.." . "..destbyte5.." . "..destbyte6.." . "..destbyte7.." . "..destbyte8.." . "..destbyte9.." . "..destbyte10);
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

