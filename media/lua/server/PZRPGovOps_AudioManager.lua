PZRPGovOps_SoundManager = {}
PZRPGovOps_SoundManager.soundEmitter = nil
PZRPGovOps_SoundManager.soundPlayedString = nil
PZRPGovOps_SoundManager.soundPlayed = nil
PZRPGovOps_SoundManager.loopAmounts = nil


function PZRPGovOps_SoundManager:ManageLoopedSound()

    if self.soundEmitter and self.soundEmitter:isPlaying(self.soundPlayed) and self.loopAmounts > 0 then
        self.soundPlayed = self.soundEmitter:playSound(self.soundPlayedString)

        self.loopAmounts = self.loopAmounts - 1
    end

    if self.loopAmounts <= 0 then
        Events.OnTick.Remove(PZRPGovOps_SoundManager.ManageLoopedSound)
    end

end
