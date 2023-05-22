local ClientCommands = {}


ClientCommands.StartSound = function(playerObj, args)
    local soundEmitter = getWorld():getFreeEmitter()
    soundEmitter:playSound("testSound", 5578, 11884, 0)
end

ClientCommands.SavePermissions = function(_, args)

    local permissionsTable = args.permissions
    local playerUsername = args.username

    local govData = ModData.get(PZRP_GovOpsVars.modDataString)
    govData[playerUsername] = permissionsTable
    ModData.add(PZRP_GovOpsVars.modDataString, govData)
end

--******************************************--


local function OnInitGlobalModData(isNewGame)
	ModData.getOrCreate(PZRP_GovOpsVars.modDataString)
end
Events.OnInitGlobalModData.Add(OnInitGlobalModData)


local function OnClientCommand(module, command, playerObj, args)
    if module == 'PZRPGovOps' and ClientCommands[command] then
        ClientCommands[command](playerObj, args)
    end
end
Events.OnClientCommand.Add(OnClientCommand)



--sendClientCommand(getPlayer(), "PZRPGovOps", "StartSound", {})