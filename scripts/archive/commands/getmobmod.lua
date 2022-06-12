---------------------------------------------------------------------------------------------------
-- func: getmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getmod")
end

function onTrigger(player)
    local effectTarget = player:getCursorTarget()
    if effectTarget == nil then
        error(player, "No current target")
    end

    local modNameByNum = {}
    for k,v in pairs(tpz.mobMod) do
        modNameByNum[v]=k
        local value = effectTarget:getMobMod(modId)
        if value ~= nil and value > 0 then
            player:PrintToPlayer(string.format("%s's Mod %i (%s) is %i", effectTarget:getName(), v, k, value))
        end
    end
    
end
