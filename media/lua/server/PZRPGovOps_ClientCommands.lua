local ClientCommands = {}


ClientCommands.StartSound = function(playerObj, args)

    local soundEmitter = getWorld():getFreeEmitter()
    soundEmitter:playSound("testSound", 5578, 11884, 0)
end

local function OnClientCommand(module, command, playerObj, args)
    if module == 'PZRPGovOps' and ClientCommands[command] then
        ClientCommands[command](playerObj, args)
    end
end

Events.OnClientCommand.Add(OnClientCommand)


sendClientCommand(getPlayer(), "PZRPGovOps", "StartSound", {})