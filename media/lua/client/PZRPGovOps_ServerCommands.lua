local ServerCommands = {}


ServerCommands.ReceiveSound = function(args)

    print("Received Broadcast audio!")
    local soundEmitter = getWorld():getFreeEmitter()

    local sound = args.sound
    local x = tonumber(args.x)
    local y = tonumber(args.y)
    local z = tonumber(args.z)

    -- TODO Make it loop
    --currentSound = sound
    soundEmitter:playSound(sound, x, y, z)

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