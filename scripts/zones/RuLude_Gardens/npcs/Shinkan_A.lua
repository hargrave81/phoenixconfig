require("scripts/globals/teleports")
require("scripts/globals/status")

function onTrigger(player,npc)
    local talkStatus = player:getVar("ArtifactA")
    if talkStatus == 0 then
        player:PrintToPlayer("Good evening, I can send you to Castle Z - Where a turtle holding the key to artifact gear exists")
        player:PrintToPlayer("This turtle holds true for masters of great axes, Singers, archers, mages and throwing masters")        
        player:setVar("ArtifactA", 1)
    elseif talkStatus == 1 then
        player:PrintToPlayer("If you'd like to be teleported to the artifact monster, talk to me one more time.")
        player:setVar("ArtifactA", 2)
    else
        player:PrintToPlayer("Safe travels")
        player:addStatusEffectEx(dsp.effect.TELEPORT)
        player:setPos(180.47, -24, -7.63, 0, 161);
    end
end