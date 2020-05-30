require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getCharVar("ArtifactA")
    if talkStatus == 0 then
        player:PrintToPlayer("Good evening, I can send you to Castle Z - Where The Flame of Fate holding the key to artifact gear exists.")
        player:PrintToPlayer("This turtle holds true for masters of great axes, Singers, archers, mages and throwing masters.")        
        player:setCharVar("ArtifactA", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setCharVar("ArtifactA", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(tpz.effect.TELEPORT)
        if player:hasItem(4181) == false then -- instant warp
            player:addItem(4181);
        end
        if player:hasItem(4182) == false then -- instant reraise
            player:addItem(4182);
        end
        player:setPos(180.47, -24, -7.63, 180, 161);
    end
end