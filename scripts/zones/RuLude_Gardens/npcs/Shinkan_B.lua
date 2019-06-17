require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getVar("ArtifactB")
    if talkStatus == 0 then
        player:PrintToPlayer("Konbanwa, I can send you to the King's Tomb - Where the Arcus Blades is holding the key to artifact gear exists.")
        player:PrintToPlayer("This turtle holds true for the most cunning, masters of shields, knights, masters of the animal kingdom, as well as trained martial artists and swordsman.")
        player:setVar("ArtifactB", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setVar("ArtifactB", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(dsp.effect.TELEPORT)
        player:setPos(24.91, 8.5, 120.2, 120, 190);
    end
end