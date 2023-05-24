local ServerCommands = {}

local audioManager = {}
audioManager.emitter = nil
audioManager.soundPlayed = nil
audioManager.soundPlayedString = nil



ServerCommands.ReceiveSound = function(args)

    print("Received Broadcast audio!")

    if audioManager.emitter == nil then
        audioManager.emitter = getWorld():getFreeEmitter()
    elseif audioManager.soundPlayedString then
        audioManager.emitter:stopSound(audioManager.soundPlayedString)
    end

    audioManager.soundPlayedString = args.sound
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)

    audioManager.soundPlayed = audioManager.soundEmitter:playSound(audioManager.soundPlayedString, x, y, z)
    
end


-----------------
local function OnServerCommands(module, command, args)
    if module == 'PZRPGovOps' then
        if ServerCommands[command] then
            args = args or {}
            ServerCommands[command](args)

        end
    end
end

Events.OnServerCommand.Add(OnServerCommands)