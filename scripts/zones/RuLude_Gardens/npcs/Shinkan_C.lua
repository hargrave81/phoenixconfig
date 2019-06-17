require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getVar("ArtifactC")
    if talkStatus == 0 then
        player:PrintToPlayer("Bonum vesperam, I can send you to Ro'Maeve - Where The Fired Urn holding the key to artifact gear exists.")
        player:PrintToPlayer("This turtle holds true for sky jumpers, callers, pirates, masters of puppetry, masters of knowledge, and those best on their feet.")        
        player:setVar("ArtifactC", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setVar("ArtifactC", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(dsp.effect.TELEPORT)
        player:setPos(0.1875, -8.13, -146.0179, 180, 122);
    end
end