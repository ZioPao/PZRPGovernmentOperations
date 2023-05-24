PZRPGovOps_SoundManager = {}


function PZRPGovOps_SoundManager.SetVariables(soundString, loopAmounts, operatorId, x, y, z)
    PZRPGovOps_SoundManager.soundString = soundString
    PZRPGovOps_SoundManager.loopAmounts = tonumber(loopAmounts)
    PZRPGovOps_SoundManager.operatorId = operatorId
    PZRPGovOps_SoundManager.receivedPing = false

    PZRPGovOps_SoundManager.x = x
    PZRPGovOps_SoundManager.y = y
    PZRPGovOps_SoundManager.z = z
end


function PZRPGovOps_SoundManager.ManageLoop()
    print("Looping!")

    local emitter = PZRPGovOps_SoundManager.emitter
    local sound = PZRPGovOps_SoundManager.soundString
    
    local x = PZRPGovOps_SoundManager.x
    local y = PZRPGovOps_SoundManager.y
    local z = PZRPGovOps_SoundManager.z

    print(emitter)
    print("Checking for " .. sound)



    if PZRPGovOps_SoundManager.receivedPing and PZRPGovOps_SoundManager.loopAmounts > 0 then
        --print("Emitter is valid and not playing that sound anymore!")
        --emitter:playSound(PZRPGovOps_SoundManager.soundString)
        sendServerCommand("PZRPGovOps", "ReceiveSound", {sound = sound, x = x, y=y, z=z})
        PZRPGovOps_SoundManager.loopAmounts = PZRPGovOps_SoundManager.loopAmounts - 1
        PZRPGovOps_SoundManager.receivedPing = false
    elseif PZRPGovOps_SoundManager.loopAmounts <= 0 then
        Events.OnTick.Remove(PZRPGovOps_SoundManager.ManageLoop)
    end

end



-- function PZRPGovOps_SoundManager:ManageLoopedSound()
--     print("Entering manage looped sound")
--     print(self.loopAmounts)
--     if self.emitter and self.emitter:isPlaying(self.soundPlayed) and self.loopAmounts > 0 then

--     end

--     if self.loopAmounts <= 0 then
--     end

-- end
