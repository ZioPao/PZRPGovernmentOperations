PZRPGovOps_SoundManager = {}
PZRPGovOps_SoundManager.emitter = nil
PZRPGovOps_SoundManager.soundPlayedString = nil
PZRPGovOps_SoundManager.soundPlayed = nil
PZRPGovOps_SoundManager.loopAmounts = nil
PZRPGovOps_SoundManager.coordinates = {x = nil, y = nil, z = nil}


function PZRPGovOps_SoundManager:ManageLoopedSound()

    if self.emitter and self.emitter:isPlaying(self.soundPlayed) and self.loopAmounts > 0 then
        self.soundPlayed = self.emitter:playSound(self.soundPlayedString)
        sendServerCommand("PZRPGovOps", "ReceiveSound", {sound = self.soundPlayedString, x = self.coordinates.x, y=self.coordinates.y, z=self.coordinates.z})
        self.loopAmounts = self.loopAmounts - 1
    end

    if self.loopAmounts <= 0 then
        Events.OnTick.Remove(PZRPGovOps_SoundManager.ManageLoopedSound)
    end

end
