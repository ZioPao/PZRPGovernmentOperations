local identificationCardForm = require("UI/Forms/PZRPGovOps_IdentificationCard")
local driversLicenseForm = require("UI/Forms/PZRPGovOps_DriversLicense")
local employmentContractForm = require("UI/Forms/PZRPGovOps_EmploymentContract")
local medicalLicenseForm = require("UI/Forms/PZRPGovOps_MedicalLicense")
local propertyDeedForm = require("UI/Forms/PZRPGovOps_PropertyDeedForm")
local vehicleRegistrationForm = require("UI/Forms/PZRPGovOps_VehicleRegistration")



local PZRPGovOps_DataEntry = ISPanel:derive("PZRPGovOps_DataEntry")
local instance = nil
local panels = {}

-- TODO Change this
panels.left = {}
panels.right = {}



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
	local modalWidth = 170
	
	if (#panels.left >= #panels.right) then
		return (absoluteX + mainPanelWidth + modalWidth * (#panels.right + 1)) - modalWidth
	elseif (#panels.left < #panels.right) then
		return absoluteX - modalWidth * (#panels.left + 1)
	end
end

function PZRPGovOps_DataEntry:openPanel(panel, modal)
	if panel then
		panel:close()
	end

	panel = modal:new(PZRPGovOps_DataEntry:calculateSidePosition(instance:getAbsoluteX(), instance.width), instance:getAbsoluteY(), 170, 500, instance)
	panel:initialise()
	panel:addToUIManager()

	local index = instance:addOpenPanel(panel:toString())
	panel:assignRemovalIndex(index)

	--getSoundManager():PlayWorldSound("ccdeTypingShort", instance.computer:getSquare(), 0, 8, 1, false)

	table.insert(panels, panel)

	return panel
end

function PZRPGovOps_DataEntry:addOpenPanel(panel)
	if (#panels.left >= #panels.right) then
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
	--Events.OnPlayerMove.Remove(OnPlayerMove)
	instance:closeOpenPanels()
	panels = {
		left = {},
		right = {}
	}
	instance:setVisible(false)
	instance:removeFromUIManager()
	PZRPGovOps_DataEntry.instance = nil
end

function PZRPGovOps_DataEntry:initialise()
    self.isPrinting = false
	ISPanel.initialise(self)
    self:create()
end

function PZRPGovOps_DataEntry:setVisible(visible)
    self.javaObject:setVisible(visible)
end

function PZRPGovOps_DataEntry:onOptionMouseDown(button, x, y)

    local workerData = FetchWorkerData()


    if instance then
        print("Instance exists")
    end

    if driversLicenseForm then
        print("Drivers form exists")
    end

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
		end
	end
end


function PZRPGovOps_DataEntry:create()
	instance = PZRPGovOps_DataEntry.instance
	local yOffset = 10
	local xPadding = 10
	
	self.mainLabel = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, PZRP_GovOpsVars.programName)) / 2, yOffset, 25, PZRP_GovOpsVars.programName, 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.mainLabel)
	
	yOffset = yOffset + 30
	
	self.descriptionLabel = ISLabel:new(xPadding, yOffset, 25, "Logging in...", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.descriptionLabel)
	
	yOffset = yOffset + 35
	
    -- TODO This is wrong!
	self.cancelBtn = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), menu, instance.onOptionMouseDown)
	self.cancelBtn.internal = "CANCEL"
	self.cancelBtn:initialise()
	self.cancelBtn:instantiate()
	self:addChild(self.cancelBtn)
	
	--getSoundManager():PlayWorldSound("ccdeTypingEnter", instance.computer:getSquare(), 0, 8, 1, false)
	--Events.OnPlayerMove.Add(OnPlayerMove)
	ModData.request(PZRP_GovOpsVars.modDataString)


	
	timer:Simple(2, function()
		if instance then
			instance:login(self, xPadding, yOffset)
		end
	end)
end

function PZRPGovOps_DataEntry:login(menu, xPadding, yOffset)
    local workerData = FetchWorkerData()

    -- Check if the player is in the list for the permissions
    if workerData then
        -- TODO This doesn't work, find a workaround
		menu:removeChild(menu.cancelBtn)
    else
        instance.descriptionLabel:setName("Access Denied")
        return
    end


    -- FORMS SECTION
    instance.descriptionLabel:setName("Forms")
	yOffset = yOffset + 25

    self.identificationCardButton = ISButton:new(xPadding, yOffset, 150, 25, "Identification", menu, instance.onOptionMouseDown)
    self.identificationCardButton.internal = "IDENTITYCARD"
    self.identificationCardButton:initialise()
    self.identificationCardButton:instantiate()
    self.identificationCardButton:setEnable(workerData.identificationCard)
    menu:addChild(self.identificationCardButton)
	yOffset = yOffset + 35

    self.driversLicenseButton = ISButton:new(xPadding, yOffset, 150, 25, "Driver's License", menu, instance.onOptionMouseDown)
    self.driversLicenseButton.internal = "DRIVERSLICENSE"
    self.driversLicenseButton:initialise()
    self.driversLicenseButton:instantiate()
    self.driversLicenseButton:setEnable(workerData.driversLicense)
    menu:addChild(self.driversLicenseButton)
	yOffset = yOffset + 35

    self.vehicleRegistrationButton = ISButton:new(xPadding, yOffset, 150, 25, "Vehicle Registration", menu, instance.onOptionMouseDown)
    self.vehicleRegistrationButton.internal = "VEHICLEREGISTRATION"
    self.vehicleRegistrationButton:initialise()
    self.vehicleRegistrationButton:instantiate()
    self.vehicleRegistrationButton:setEnable(workerData.vehicleRegistration)
    menu:addChild(self.vehicleRegistrationButton)
	yOffset = yOffset + 35

    self.employmentContractButton = ISButton:new(xPadding, yOffset, 150, 25, "Employment Contract", menu, instance.onOptionMouseDown)
    self.employmentContractButton.internal = "EMPLOYMENTCONTRACT"
    self.employmentContractButton:initialise()
    self.employmentContractButton:instantiate()
    self.employmentContractButton:setEnable(workerData.employmentContract)
    menu:addChild(self.employmentContractButton)
	yOffset = yOffset + 35

    self.medicalLicenseButton = ISButton:new(xPadding, yOffset, 150, 25, "Medical License", menu, instance.onOptionMouseDown)
    self.medicalLicenseButton.internal = "MEDICALLICENSE"
    self.medicalLicenseButton:initialise()
    self.medicalLicenseButton:instantiate()
    self.medicalLicenseButton:setEnable(workerData.medicalLicense)
    menu:addChild(self.medicalLicenseButton)
	yOffset = yOffset + 35

    self.propertyDeedButton = ISButton:new(xPadding, yOffset, 150, 25, "Property Deed", menu, instance.onOptionMouseDown)
    self.propertyDeedButton.internal = "PROPERTYDEED"
    self.propertyDeedButton:initialise()
    self.propertyDeedButton:instantiate()
    self.propertyDeedButton:setEnable(workerData.propertyDeed)
    menu:addChild(self.propertyDeedButton)
	yOffset = yOffset + 35


    -- BROADCAST MANAGEMENT
	self.broadcastSoundLabel = ISLabel:new(xPadding, yOffset, 25, "Broadcast Management", 1, 1, 1, 1, UIFont.Medium, true)
	menu:addChild(self.broadcastSoundLabel)
	yOffset = yOffset + 25

    self.broadcastStartSoundButton = ISButton:new(xPadding, yOffset, 150, 25, "Start Broadcast Sound", menu, instance.onOptionMouseDown)
    self.broadcastStartSoundButton.internal = "STARTBROADCAST"
    self.broadcastStartSoundButton:initialise()
    self.broadcastStartSoundButton:instantiate()
    self.broadcastStartSoundButton:setEnable(workerData.broadcastAlarm)

    menu:addChild(self.broadcastStartSoundButton)
	yOffset = yOffset + 35

    self.broadcastStopSoundButton = ISButton:new(xPadding, yOffset, 150, 25, "Stop Broadcast Sound", menu, instance.onOptionMouseDown)
    self.broadcastStopSoundButton.internal = "STOPBROADCAST"
    self.broadcastStopSoundButton:initialise()
    self.broadcastStopSoundButton:instantiate()
    self.broadcastStopSoundButton:setEnable(workerData.broadcastAlarm)
    menu:addChild(self.broadcastStopSoundButton)
	yOffset = yOffset + 35



	-------------------------

    self.cancel = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), menu, instance.onOptionMouseDown)
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