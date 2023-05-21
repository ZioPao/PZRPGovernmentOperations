local dataEntryPanel = require "UI/PZRPGovOps_DataEntry"
local editPermissionsPanel = require "UI/PZRPGovOps_DataEntry"


PZRP_GovernmentOperations = {}
local UI_SCALE = getTextManager():getFontHeight(UIFont.Small) / 14



local function OnAccessGovComputer(computer)

	print("Accessing gov computer")
	local x = (getCore():getScreenWidth() - 400 * UI_SCALE)/2
	local y = (getCore():getScreenHeight() - 400 * UI_SCALE)/2
	local width = 330
	local height = 500

	local computerMenu = dataEntryPanel:new(x, y, width, height, computer)
	computerMenu:initialise()
	computerMenu:addToUIManager()
end

local function OnEditPermissions(computer)
	print("Accessing gov computer to edit permissions")
	local x = (getCore():getScreenWidth() - 400 * UI_SCALE)/2
	local y = (getCore():getScreenHeight() - 400 * UI_SCALE)/2
	local width = 330
	local height = 500

	local computerMenu = editPermissionsPanel:new(x, y, width, height, computer)
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
		local isAdmin = (not getPlayer():isAccessLevel('None') or isDebugEnabled())


		if computerData["isGovSoftwareInstalled"] then
			subContext:addOption("Start Government Software", computer, OnAccessGovComputer)

			if isAdmin then
				subContext:addOption("Set worker permissions", computer, OnEditPermissions)
				subContext:addOption("Uninstall Government Software", computer, OnUninstallGovSoftware)
			end

		elseif isAdmin then
			subContext:addOption("Install Government Software", computer, OnInstallGovSoftware)
		end
	end
end