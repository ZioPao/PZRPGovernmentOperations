local ClientCommands = {}


local currentSound = nil


ClientCommands.TestSound = function(playerObj, args)

    --local soundEmitter = getWorld():getFreeEmitter()
    --soundEmitter:playSound("testSound", 8000, 7900, 0)
    sendServerCommand("PZRPGovOps", "ReceiveSound", {sound = "testSound", x = 8000, y = 7900, z= 0})

end



ClientCommands.StartSound = function(playerObj, args)

    print("Server received broadcast audio! Sending it!")

    local sound = args.sound
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)

    local isLoop = args.isLoop

    PZRPGovOps_SoundManager.emitter = getWorld():getFreeEmitter()
    PZRPGovOps_SoundManager.soundPlayedString = sound
    PZRPGovOps_SoundManager.soundPlayed = PZRPGovOps_SoundManager.emitter:playSound(PZRPGovOps_SoundManager.soundPlayedString, x, y, z)


    sendServerCommand("PZRPGovOps", "ReceiveSound", {sound = sound, x = x, y=y, z=z})
    if isLoop then
        PZRPGovOps_SoundManager.loopAmounts = args.loopAmounts
        PZRPGovOps_SoundManager.coordinates.x = x
        PZRPGovOps_SoundManager.coordinates.y = y
        PZRPGovOps_SoundManager.coordinates.z = z
        Events.OnTick.Add(PZRPGovOps_SoundManager.ManageLoopedSound)
    end
end


ClientCommands.SavePermissions = function(_, args)
    print("Saving permissions!")
    local permissionsTable = args.permissions
    local playerUsername = string.gsub(args.username, "%s+", "")        -- so the player can actually write it correctly


    print(playerUsername)


    local govData = ModData.get(PZRP_GovOpsVars.modDataString)
    govData[playerUsername] = permissionsTable
    ModData.add(PZRP_GovOpsVars.modDataString, govData)
end

--******************************************--


local function OnInitGlobalModData()
	local modData = ModData.getOrCreate(PZRP_GovOpsVars.modDataString)

    if modData then
        print("Yay it exists!")
    end
end
Events.OnInitGlobalModData.Add(OnInitGlobalModData)


local function OnClientCommand(module, command, playerObj, args)
    if module == 'PZRPGovOps' and ClientCommands[command] then
        ClientCommands[command](playerObj, args)
    end
end
Events.OnClientCommand.Add(OnClientCommand)



