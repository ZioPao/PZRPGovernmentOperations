local ServerCommands = {}

local audioManager = {}
audioManager.emitter = nil
audioManager.soundString = nil


-- this fucking should run ONLY on the operator client
audioManager.SyncLoopedAudio = function()
    --print("Loop to sync audio")
    if not audioManager.emitter:isPlaying(audioManager.soundString) then

        --print("Ping!!")
        -- Send ping to start the sound again
        sendClientCommand(getPlayer(), "PZRPGovOps", "ReceivePingForSound", {})
        Events.OnTick.Remove(audioManager.SyncLoopedAudio)
    end
end




ServerCommands.ReceiveSound = function(args)

    print("GovOps: received Broadcast audio!")

    if PZRP_GovOpsMain.isReady == nil or PZRP_GovOpsMain.isReady == false then
        print("Client not ready")
        return
    end


    local emitter = getWorld():getFreeEmitter()
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)
    emitter:playSound(args.sound, x, y, z)
    if args.operator then
        print("GovOps: ".. tostring(args.operator) .. "is operator")
        if args.operator == getPlayer():getOnlineID() then
            -- start sync
            print("GovOps: current player is operator, starting sync")
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