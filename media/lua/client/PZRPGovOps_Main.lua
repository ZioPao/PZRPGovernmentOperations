PZRP_GovOpsMain = {}
PZRP_GovOpsMain.isReady = false
--PZRP_GovOpsMain.startTime = 0

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


local function OnAccessGovComputer(computer, govPanel)
	local UI_SCALE = getTextManager():getFontHeight(UIFont.Small) / 14
	local X = (getCore():getScreenWidth() - 400 * UI_SCALE)/2
	local Y = (getCore():getScreenHeight() - 600 * UI_SCALE)/2
	local computerMenu = govPanel:new(X, Y, PZRP_GovOpsVars.dataEntryWidth, PZRP_GovOpsVars.dataEntryHeigth, computer)
	computerMenu:initialise()
	computerMenu:addToUIManager()
end


local function OnUninstallGovSoftware(computer)
	--print("Uninstalling software")
	computer:getModData()["isGovSoftwareInstalled"] = nil
	computer:transmitModData()
end
local function OnInstallGovSoftware(computer)
	--print("Installing software")
	computer:getModData()["isGovSoftwareInstalled"] = true
	computer:transmitModData()
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


--------------------------------

-- local function ManageDelayedPacketsBugLoop()

-- 	local status = getMPStatus()
-- 	if PZRP_GovOpsMain.startTime == 0 then
-- 		PZRP_GovOpsMain.startTime = tonumber(status.serverTime)
-- 		return
-- 	end


-- 	--print("Start time: " .. tostring(PZRP_GovOpsMain.startTime))
-- 	PZRP_GovOpsMain.currentTime = tonumber(status.serverTime)
-- 	--print(currentTime)


-- 	if PZRP_GovOpsMain.currentTime > PZRP_GovOpsMain.startTime + 0.01 then
-- 		print("GovOps: sounds can start")
-- 		Events.OnTick.Remove(ManageDelayedPacketsBugLoop)
-- 	end
-- end

local function ManageDelayedPacketsBug()


	--PZRP_GovOpsMain.startTime = 0
	--PZRP_GovOpsMain.currentTime = 0

	timer:Simple(10, function()
		print("GovOps: client is ready to accept sounds")
		PZRP_GovOpsMain.isReady = true
	end)

	--Events.OnTick.Add(ManageDelayedPacketsBugLoop)
end

Events.OnGameStart.Add(ManageDelayedPacketsBug)