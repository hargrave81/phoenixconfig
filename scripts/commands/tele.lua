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
            local deststr = tostring(bytes);
            local vhazl = getBytePos(destination,49);
            local altep = getBytePos(destination,114);
            local yhoat = getBytePos(destination,115);
            local holla = getBytePos(destination,41);
            local mea = getBytePos(destination,23);
            local dem = getBytePos(destination,81);
            if yhoat == 10 or deststr == "yhoat" then
                if (player:hasKeyItem(dsp.ki.YHOATOR_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.YHOAT,0,4.7)
                    player:PrintToPlayer("Sending you to Yhoat ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end

            if vahzl == 10 or deststr == "vhazl" then
                if (player:hasKeyItem(dsp.ki.VAHZL_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.VAHZL,0,4.7)
                    player:PrintToPlayer("Sending you to Vhazl ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end

            if altep == 10 or deststr == "altep" then
                if (player:hasKeyItem(dsp.ki.ALTEPA_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.ALTEP,0,4.7)
                    player:PrintToPlayer("Sending you to Altep ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end

            if holla == 10 or deststr == "holla" then
                if (player:hasKeyItem(dsp.ki.HOLLA_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.HOLLA,0,4.7)
                    player:PrintToPlayer("Sending you to Holla ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end


            if mea == 10 or deststr == "mea" then
                if (player:hasKeyItem(dsp.ki.MEA_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.MEA,0,4.7)
                    player:PrintToPlayer("Sending you to Mea ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end

            if dem == 10 or deststr == "dem" then
                if (player:hasKeyItem(dsp.ki.DEM_GATE_CRYSTAL) == true) then
                    player:addStatusEffectEx(dsp.effect.TELEPORT,0,dsp.teleport.id.DEM,0,4.7)
                    player:PrintToPlayer("Sending you to Dem ...")
                    player:setMsg(dsp.msg.basic.MAGIC_TELEPORT)
                else
                    player:PrintToPlayer("You lack the crystal")
                    player:setMsg(dsp.msg.basic.NO_EFFECT)
                end                                
                return;
            end
            return;
        end
    end
    player:PrintToPlayer("!tele can only be used in cities");
end;

