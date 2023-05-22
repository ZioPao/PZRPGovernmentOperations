local ClientCommands = {}


ClientCommands.StartSound = function(playerObj, args)
    local soundEmitter = getWorld():getFreeEmitter()

    local sound = args.sound
    local x = args.x
    local y = args.y
    local z = args.z


    soundEmitter:playSound(sound, x, y, z)
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



