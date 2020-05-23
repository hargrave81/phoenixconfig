require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getCharVar("ArtifactC")
    if talkStatus == 0 then
        player:PrintToPlayer("Bonum vesperam, I can send you to Ro'Maeve - Where The Fired Urn holding the key to artifact gear exists.")
        player:PrintToPlayer("This turtle holds true for sky jumpers, callers, pirates, masters of puppetry, masters of knowledge, and those best on their feet.")        
        player:setCharVar("ArtifactC", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setCharVar("ArtifactC", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(dsp.effect.TELEPORT)
        if player:hasItem(4181) == false then -- instant warp
            player:addItem(4181);
        end
        if player:hasItem(4182) == false then -- instant reraise
            player:addItem(4182);
        end
        player:setPos(0.1875, -8.13, -146.0179, 180, 122);
    end
end