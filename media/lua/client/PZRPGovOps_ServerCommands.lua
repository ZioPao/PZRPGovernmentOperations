local ServerCommands = {}


ServerCommands.ReceiveSound = function(args)

    print("Received Broadcast audio!")

    if PZRPGovOps_SoundManager.soundEmitter == nil then
        PZRPGovOps_SoundManager.soundEmitter = getWorld():getFreeEmitter()
    end

    local sound = args.sound
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)


    -- Force stop old sound
    if PZRPGovOps_SoundManager.soundPlayed then
        PZRPGovOps_SoundManager.soundEmitter:stopSound(PZRPGovOps_SoundManager.soundPlayedString)

    end


    PZRPGovOps_SoundManager.soundPlayedString = sound
    PZRPGovOps_SoundManager.soundPlayed = PZRPGovOps_SoundManager.soundEmitter:playSound(sound, x, y, z)
    
    local isLoop = args.isLoop
    if isLoop then
        PZRPGovOps_SoundManager.loopAmounts = args.loopAmounts
        Events.OnTick.Add(PZRPGovOps_SoundManager.ManageLoopedSound)
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