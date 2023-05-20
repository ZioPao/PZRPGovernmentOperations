local PZRPGovOps_DataEntry = require "UI/PZRPGovOps_DataEntry"
PZRP_GovernmentOperations = {}
PZRP_GovernmentOperations.modDataString = "PZRPGovernmentData"
local UI_SCALE = getTextManager():getFontHeight(UIFont.Small) / 14



local function OnAccessGovComputer(computer, govData)

	print("Accessing gov computer")
	local x = (getCore():getScreenWidth() - 400 * UI_SCALE)/2
	local y = (getCore():getScreenHeight() - 400 * UI_SCALE)/2
	local width = 330
	local height = 500

	local computerMenu = PZRPGovOps_DataEntry:new(x, y, width, height, computer, govData)
	computerMenu:initialise()
	computerMenu:addToUIManager()
end

local function OnUninstallGovSoftware(computer)
	print("Uninstalling software")
	computer:getModData()["isGovSoftwareInstalled"] = nil
end
local function OnInstallGovSoftware(computer)
	print("Installing software")
	computer:getModData()["isGovSoftwareInstalled"] = true
end



local og_ComputerModOnInteractionMenuPoweredOptions = ComputerMod.Events.OnInteractionMenuPoweredOptions
function ComputerMod.Events.OnInteractionMenuPoweredOptions(playerNum, computer, state, option, subContext)
	if state then
		og_ComputerModOnInteractionMenuPoweredOptions(playerNum, computer, state, option, subContext)

		local computerData = computer:getModData()

		
		-- TODO Only admins can install the software

		if computerData["isGovSoftwareInstalled"] then
			local governmentData = ModData.get(PZRP_GovernmentOperations.modDataString)
			subContext:addOption("Start Government Software", computer, OnAccessGovComputer, governmentData)
			subContext:addOption("Uninstall Government Software", computer, OnUninstallGovSoftware)
		else
			subContext:addOption("Install Government Software", computer, OnInstallGovSoftware)
		end
	end
end