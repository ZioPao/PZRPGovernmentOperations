PZRP_GovOpsMain = {}


PZRP_GovOpsMain.PrintDocumentAndCopy = function(documentType, title, contents)
	print("Printing document for " .. documentType)
	local documentItem = InventoryItemFactory.CreateItem(documentType)
	local documentCopyItem = InventoryItemFactory.CreateItem("Base.SheetPaper2")

	documentItem:setName(title)
	documentItem:setCanBeWrite(true)
	documentItem:addPage(1, contents)
	documentItem:setLockedBy(getPlayer():getUsername())

	documentCopyItem:setName(title)
	documentCopyItem:setCanBeWrite(true)
	documentCopyItem:addPage(1, contents)
	documentCopyItem:setLockedBy(getPlayer():getUsername())

	getPlayer():getInventory():AddItem(documentItem)
	getPlayer():getInventory():AddItem(documentCopyItem)


end

--******************************************--


local dataEntryPanel = require "UI/PZRPGovOps_DataEntry"
local editPermissionsPanel = require "UI/PZRPGovOps_EditPermissions"




local UI_SCALE = getTextManager():getFontHeight(UIFont.Small) / 14
local X = (getCore():getScreenWidth() - 400 * UI_SCALE)/2
local Y = (getCore():getScreenHeight() - 400 * UI_SCALE)/2
local WIDTH = 330
local HEIGHT = 500


local function OnAccessGovComputer(computer, govPanel)
	local computerMenu = govPanel:new(X, Y, WIDTH, HEIGHT, computer)
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


-- We're gonna override a function from ComputerMod to inject our stuff right into its context
local og_ComputerModOnInteractionMenuPoweredOptions = ComputerMod.Events.OnInteractionMenuPoweredOptions
function ComputerMod.Events.OnInteractionMenuPoweredOptions(playerNum, computer, state, option, subContext)
	if state then
		og_ComputerModOnInteractionMenuPoweredOptions(playerNum, computer, state, option, subContext)

		local computerData = computer:getModData()
		local isAdmin = not getPlayer():isAccessLevel('None') or isDebugEnabled()


		if computerData["isGovSoftwareInstalled"] then
			subContext:addOption("Start Government Software", computer, OnAccessGovComputer, dataEntryPanel)

			if isAdmin then
				subContext:addOption("Set worker permissions", computer, OnAccessGovComputer, editPermissionsPanel)
				subContext:addOption("Uninstall Government Software", computer, OnUninstallGovSoftware)
			end

		elseif isAdmin then
			subContext:addOption("Install Government Software", computer, OnInstallGovSoftware)
		end
	end
end

--***********************************************--

local function OnReceiveGlobalModData(module, packet)
	if module ~= PZRP_GovOpsVars.modDataString then return end
	if packet then
		ModData.add(module, packet)
	end
end

Events.OnReceiveGlobalModData.Add(OnReceiveGlobalModData)