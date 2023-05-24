local ServerCommands = {}

local audioManager = {}
audioManager.emitter = nil
audioManager.soundString = nil


audioManager.SyncLoopedAudio = function()

    if not audioManager.emitter:isPlaying(audioManager.soundString) then
        -- Send ping to start the sound again
        sendClientCommand(getPlayer(), "PZRPGovOps", "ReceivePingForSound", {})
    end

    Events.OnTick.Remove(audioManager.SyncLoopedAudio)

end




ServerCommands.ReceiveSound = function(args)

    print("Received Broadcast audio!")

    local emitter = getWorld():getFreeEmitter()
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)

    emitter:playSound(args.sound, x, y, z)




    if args.operator then

        if args.operator == getPlayer():getOnlineID() then
            -- start sync


            audioManager.emitter = emitter
            audioManager.soundString = args.sound

            Events.OnTick.Add(audioManager.SyncLoopedAudio)
        end
    end
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