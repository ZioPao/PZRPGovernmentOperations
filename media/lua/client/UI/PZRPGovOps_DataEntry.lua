local identificationCardForm = require("UI/Forms/PZRPGovOps_IdentificationCard")
local driversLicenseForm = require("UI/Forms/PZRPGovOps_DriversLicense")
local employmentContractForm = require("UI/Forms/PZRPGovOps_EmploymentContract")
local medicalLicenseForm = require("UI/Forms/PZRPGovOps_MedicalLicense")
local propertyDeedForm = require("UI/Forms/PZRPGovOps_PropertyDeed")
local vehicleRegistrationForm = require("UI/Forms/PZRPGovOps_VehicleRegistration")

-----------------------------

local PZRPGovOps_DataEntry = ISPanel:derive("PZRPGovOps_DataEntry")
local instance = nil
local panels = {}

-- TODO Change this
panels.left = {}
panels.right = {}

local function OnPlayerMove(player)
    if player:isLocalPlayer() and player:DistToProper(PZRPGovOps_DataEntry.instance.computer) > 2 then
		PZRPGovOps_DataEntry.instance:close()
	end

end

local function FetchWorkerData()

    local modData = ModData.get(PZRP_GovOpsVars.modDataString)

    if modData == nil then
        print("No ModData available")
        return false
    end

    local workerData = modData[getPlayer():getUsername()]

    if workerData then
        return workerData
    end

    return false
end

--****************************--
-- Panels

function PZRPGovOps_DataEntry:calculateSidePosition(absoluteX, mainPanelWidth)
	
	if (#panels.left >= #panels.right) then
		return (absoluteX + mainPanelWidth + PZRP_GovOpsVars.panelWidth * (#panels.right + 1)) - PZRP_GovOpsVars.panelWidth
	elseif (#panels.left < #panels.right) then
		return absoluteX - PZRP_GovOpsVars.panelWidth * (#panels.left + 1)
	end
end

function PZRPGovOps_DataEntry:openPanel(panel, modal)
	if panel then
		panel:close()
        return
	end


	panel = PZRPGovOps_BaseForm:new(PZRPGovOps_DataEntry:calculateSidePosition(instance:getAbsoluteX(), instance.width), instance:getAbsoluteY(), 200, 500, instance, modal)
	panel:initialise()
	panel:addToUIManager()

	local index = instance:addOpenPanel(panel:toString())
	panel:assignRemovalIndex(index)

	--getSoundManager():PlayWorldSound("PZRPGovOps_Typing", instance.computer:getSquare(), 0, 8, 1, false)

	table.insert(panels, panel)

	return panel
end

function PZRPGovOps_DataEntry:addOpenPanel(panel)
	if #panels.left >= #panels.right then
		table.insert(panels.right, panel)
		return #panels.right
	else
		table.insert(panels.left, panel)
		return #panels.left
	end
end

function PZRPGovOps_DataEntry:closeOpenPanels()
	for i = 1, #panels do
		panels[i]:close()
	end
end

function PZRPGovOps_DataEntry:removeOpenPanel(removalIndex, panel)
	if (panels.right[removalIndex] == panel) then
		panels.right[removalIndex] = nil
	elseif (panels.left[removalIndex] == panel) then
		panels.left[removalIndex] = nil
	end
end




-----------------------------------

function PZRPGovOps_DataEntry:close()
	Events.OnPlayerMove.Remove(OnPlayerMove)
	instance:closeOpenPanels()
	panels = {
		left = {},
		right = {}
	}

    if instance.broadcastMenu then
        instance.broadcastMenu:close()
    end



	instance:setVisible(false)
	instance:removeFromUIManager()
	PZRPGovOps_DataEntry.instance = nil
end

function PZRPGovOps_DataEntry:initialise()
	ISPanel.initialise(self)
    self:create()
end

function PZRPGovOps_DataEntry:setVisible(visible)
    self.javaObject:setVisible(visible)
end

function PZRPGovOps_DataEntry:onOptionMouseDown(button, x, y)

    local workerData = FetchWorkerData()

	if button.internal == "CANCEL" then
		instance:closeOpenPanels()
		instance:close()
    elseif workerData then

		if button.internal == "IDENTIFICATION" and workerData.identificationCard then
			instance.identificationPanel = instance:openPanel(instance.identificationPanel, identificationCardForm)
		elseif button.internal == "DRIVERSLICENSE" and workerData.driversLicense then
			instance.driversLicensePanel = instance:openPanel(instance.driversLicensePanel, driversLicenseForm)
		elseif button.internal == "VEHICLEREGISTRATION" and workerData.vehicleRegistration then
			instance.vehicleRegistrationPanel = instance:openPanel(instance.vehicleRegistrationPanel, vehicleRegistrationForm)
        elseif button.internal == "EMPLOYMENTCONTRACT" and workerData.employmentContract then
			instance.employmentContractPanel = instance:openPanel(instance.employmentContractPanel, employmentContractForm)
        elseif button.internal == "MEDICALLICENSE" and workerData.medicalLicense then
			instance.medicalLicensePanel = instance:openPanel(instance.medicalLicensePanel, medicalLicenseForm)
        elseif button.internal == "PROPERTYDEED" and workerData.propertyDeed then
			instance.propertyDeedPanel = instance:openPanel(instance.propertyDeedPanel, propertyDeedForm)
        elseif button.internal == "OPENBROADCASTMENU" and workerData.broadcastAlarm then
            -- Special case I guess. Opens it on the right side or something
            instance.broadcastMenu = PZRPGovOps_SoundsListViewer.OnOpenPanel()
		end
	end
end


function PZRPGovOps_DataEntry:create()
	instance = PZRPGovOps_DataEntry.instance
	local yOffset = 10
	
	self.mainLabel = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, PZRP_GovOpsVars.programName)) / 2, yOffset, 25, PZRP_GovOpsVars.programName, 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.mainLabel)
	yOffset = yOffset + 30


	self.descriptionLabel = ISLabel:new(PZRP_GovOpsVars.xPadding, yOffset, 25, "Logging in...", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.descriptionLabel)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries
	
	self.cancelBtn = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, 150, 25, getText("UI_btn_close"), menu, instance.onOptionMouseDown)
	self.cancelBtn.internal = "CANCEL"
	self.cancelBtn:initialise()
	self.cancelBtn:instantiate()
	self:addChild(self.cancelBtn)
	
	--getSoundManager():PlayWorldSound("ccdeTypingEnter", instance.computer:getSquare(), 0, 8, 1, false)
	
    Events.OnPlayerMove.Add(OnPlayerMove)
	ModData.request(PZRP_GovOpsVars.modDataString)


	
	timer:Simple(2, function()
		if instance then
			instance:login(self, yOffset)
		end
	end)
end

function PZRPGovOps_DataEntry:login(menu, yOffset)
    local workerData = FetchWorkerData()

    -- Check if the player is in the list for the permissions
    if workerData then
        yOffset = yOffset - 35
		menu:removeChild(menu.cancelBtn)
    else
        instance.descriptionLabel:setName("Access Denied")
        return
    end


    local entryWidth = self.width - 20




    -- FORMS SECTION
    instance.descriptionLabel:setName("Available Forms")
	yOffset = yOffset + 25

    self.identificationCardButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Identification", menu, instance.onOptionMouseDown)
    self.identificationCardButton.internal = "IDENTIFICATION"
    self.identificationCardButton:initialise()
    self.identificationCardButton:instantiate()
    self.identificationCardButton:setEnable(workerData.identificationCard)
    menu:addChild(self.identificationCardButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    self.driversLicenseButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Driver's License", menu, instance.onOptionMouseDown)
    self.driversLicenseButton.internal = "DRIVERSLICENSE"
    self.driversLicenseButton:initialise()
    self.driversLicenseButton:instantiate()
    self.driversLicenseButton:setEnable(workerData.driversLicense)
    menu:addChild(self.driversLicenseButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    self.vehicleRegistrationButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Vehicle Registration", menu, instance.onOptionMouseDown)
    self.vehicleRegistrationButton.internal = "VEHICLEREGISTRATION"
    self.vehicleRegistrationButton:initialise()
    self.vehicleRegistrationButton:instantiate()
    self.vehicleRegistrationButton:setEnable(workerData.vehicleRegistration)
    menu:addChild(self.vehicleRegistrationButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    self.employmentContractButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Employment Contract", menu, instance.onOptionMouseDown)
    self.employmentContractButton.internal = "EMPLOYMENTCONTRACT"
    self.employmentContractButton:initialise()
    self.employmentContractButton:instantiate()
    self.employmentContractButton:setEnable(workerData.employmentContract)
    menu:addChild(self.employmentContractButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    self.medicalLicenseButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Medical License", menu, instance.onOptionMouseDown)
    self.medicalLicenseButton.internal = "MEDICALLICENSE"
    self.medicalLicenseButton:initialise()
    self.medicalLicenseButton:instantiate()
    self.medicalLicenseButton:setEnable(workerData.medicalLicense)
    menu:addChild(self.medicalLicenseButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    self.propertyDeedButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Property Deed", menu, instance.onOptionMouseDown)
    self.propertyDeedButton.internal = "PROPERTYDEED"
    self.propertyDeedButton:initialise()
    self.propertyDeedButton:instantiate()
    self.propertyDeedButton:setEnable(workerData.propertyDeed)
    menu:addChild(self.propertyDeedButton)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries


    -- BROADCAST MANAGEMENT
	self.broadcastSoundLabel = ISLabel:new(PZRP_GovOpsVars.xPadding, yOffset, 25, "Broadcast Management", 1, 1, 1, 1, UIFont.Medium, true)
	menu:addChild(self.broadcastSoundLabel)
	yOffset = yOffset + 25

    self.broadcastStartSoundButton = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, entryWidth, 25, "Open Broadcast Menu", menu, instance.onOptionMouseDown)
    self.broadcastStartSoundButton.internal = "OPENBROADCASTMENU"
    self.broadcastStartSoundButton:initialise()
    self.broadcastStartSoundButton:instantiate()
    self.broadcastStartSoundButton:setEnable(workerData.broadcastAlarm)
    menu:addChild(self.broadcastStartSoundButton)




	-------------------------

    self.cancel = ISButton:new(PZRP_GovOpsVars.xPadding, self.height - 35, entryWidth, 25, getText("UI_btn_close"), menu, instance.onOptionMouseDown)
    self.cancel.internal = "CANCEL"
    self.cancel:initialise()
    self.cancel:instantiate()
    menu:addChild(self.cancel)
	
end


--****************************--

function PZRPGovOps_DataEntry:new(x, y, width, height, computer)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.width = width
    o.height = height

    o.variableColor={r=0.9, g=0.55, b=0.1, a=1}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5}
    o.moveWithMouse = true
    o.computer = computer
    PZRPGovOps_DataEntry.instance = o
    return o
end

return PZRPGovOps_DataEntry