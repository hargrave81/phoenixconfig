require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getCharVar("ArtifactB")
    if talkStatus == 0 then
        player:PrintToPlayer("Konbanwa, I can send you to the King's Tomb - Where the Arcus Blades is holding the key to artifact gear exists.")
        player:PrintToPlayer("This turtle holds true for the most cunning, masters of shields, knights, masters of the animal kingdom, as well as trained martial artists and swordsman.")
        player:setCharVar("ArtifactB", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setCharVar("ArtifactB", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(dsp.effect.TELEPORT)
        if player:hasItem(4181) == false then -- instant warp
            player:addItem(4181);
        end
        if player:hasItem(4182) == false then -- instant reraise
            player:addItem(4182);
        end
        player:setPos(24.91, 8.5, 120.2, 120, 190);        
    end
end