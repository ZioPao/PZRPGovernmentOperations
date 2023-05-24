local ClientCommands = {}


local currentSound = nil


ClientCommands.TestSound = function(playerObj, args)

    --local soundEmitter = getWorld():getFreeEmitter()
    --soundEmitter:playSound("testSound", 8000, 7900, 0)
    sendServerCommand("PZRPGovOps", "ReceiveSound", {sound = "testSound", x = 8000, y = 7900, z= 0})

end

ClientCommands.ReceivePingForSound = function(playerObj, args)

    PZRPGovOps_SoundManager.receivedPing = true
    

end

ClientCommands.StartSound = function(playerObj, args)

    print("Server received broadcast audio! Sending it!")

    local sound = args.sound
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)

    local isLoop = args.isLoop


    -----------------

    -- print("Checking type of args.loopAmounts")
    -- print(type(args.loopAmounts))
    -- local test = tonumber(args.loopAmounts)
    -- print(type(test))
    -- print(test)

    -----------------

    local operator = nil


    if isLoop then
        --local emitter = getWorld():getFreeEmitter()
       -- emitter:playSound(sound, x, y, z)

        operator = playerObj:getOnlineID()
        PZRPGovOps_SoundManager.SetVariables(sound, args.loopAmounts, operator, x, y, z)
        --print("Generated this emitter in server")
        --print(emitter)
        Events.OnTick.Add(PZRPGovOps_SoundManager.ManageLoop)
    end

    sendServerCommand("PZRPGovOps", "ReceiveSound", {operator = operator, sound = sound, x = x, y=y, z=z})






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



