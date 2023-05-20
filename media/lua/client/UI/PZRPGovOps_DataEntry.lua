local PZRPGovOps_DataEntry = ISPanel:derive("PZRPGovOps_DataEntry")
local instance = nil

function PZRPGovOps_DataEntry:create()
	instance = PZRPGovOps_DataEntry.instance
	local yOffset = 10
	local xPadding = 10
	
	self.mainLabel = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, "Clerk Computer")) / 2, yOffset, 25, "Clerk Computer", 1, 1, 1, 1, UIFont.Large, true)
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
	ModData.request(PZRP_GovernmentOperations.modDataString)
	
	timer:Simple(2, function()
		if (instance) then
			instance:login(self, xPadding, yOffset)
		end
	end)
end

function PZRPGovOps_DataEntry:login(menu, xPadding, yOffset)
	local xColumnTwo = xPadding + 160
	local yColumnTwo = yOffset - 35
    
    local workerData = ModData.get(PZRP_GovernmentOperations.modDataString)[getPlayer():getUsername()]

    -- Check if the player is in the list for the permissions
    if workerData then
		menu:removeChild(menu.cancel)
    else
        instance.descriptionLabel:setName("Access Denied")
        return
    end


    -- FORMS SECTION
    instance.descriptionLabel:setName("Forms")
	yOffset = yOffset + 25

    self.identificationCardButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.identityCard and "" or "[X] ") .. "Identification", menu, instance.onOptionMouseDown)
    self.identificationButton.internal = "IDENTITYCARD"
    self.identificationButton:initialise()
    self.identificationButton:instantiate()
    menu:addChild(self.identificationButton)
	yOffset = yOffset + 35

    self.driversLicenseButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.driversLicense and "" or "[X] ") .. "Driver's License", menu, instance.onOptionMouseDown)
    self.driversLicenseButton.internal = "DRIVERSLICENSE"
    self.driversLicenseButton:initialise()
    self.driversLicenseButton:instantiate()
    menu:addChild(self.driversLicenseButton)
	yOffset = yOffset + 35

    self.vehicleRegistrationButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.vehicleRegistration and "" or "[X] ") .. "Vehicle Registration", menu, instance.onOptionMouseDown)
    self.vehicleRegistrationButton.internal = "VEHICLEREGISTRATION"
    self.vehicleRegistrationButton:initialise()
    self.vehicleRegistrationButton:instantiate()
    menu:addChild(self.vehicleRegistrationButton)
	yOffset = yOffset + 35

    self.employmentContractButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.employmentContract and "" or "[X] ") .. "Employment Contract", menu, instance.onOptionMouseDown)
    self.vehicleRegistrationButton.internal = "EMPLOYMENTCONTRACT"
    self.vehicleRegistrationButton:initialise()
    self.vehicleRegistrationButton:instantiate()
    menu:addChild(self.vehicleRegistrationButton)
	yOffset = yOffset + 35

    self.medicalLicenseButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.medicalLicense and "" or "[X] ") .. "Medical License", menu, instance.onOptionMouseDown)
    self.medicalLicenseButton.internal = "MEDICALLICENSE"
    self.medicalLicenseButton:initialise()
    self.medicalLicenseButton:instantiate()
    menu:addChild(self.medicalLicenseButton)
	yOffset = yOffset + 35

    self.propertyDeedButton = ISButton:new(xPadding, yOffset, 150, 25, (workerData.propertyDeed and "" or "[X] ") .. "Property Deed", menu, instance.onOptionMouseDown)
    self.propertyDeedButton.internal = "PROPERTYDEED"
    self.propertyDeedButton:initialise()
    self.propertyDeedButton:instantiate()
    menu:addChild(self.propertyDeedButton)
	yOffset = yOffset + 35


    -- BROADCAST MANAGEMENT
	self.broadcastSoundLabel = ISLabel:new(xPadding, yOffset, 25, "Broadcast Management", 1, 1, 1, 1, UIFont.Medium, true)
	menu:addChild(self.loanInfo)
	yOffset = yOffset + 25

    self.broadcastStartSoundButton = ISButton:new(xPadding, yOffset, 150, 25, "Start Broadcast Sound", menu, instance.onOptionMouseDown)
    self.broadcastStartSoundButton.internal = "STARTBROADCAST"
    self.broadcastStartSoundButton:initialise()
    self.broadcastStartSoundButton:instantiate()
    menu:addChild(self.typingEnterButton)
	yOffset = yOffset + 35

    self.broadcastStopSoundButton = ISButton:new(xPadding, yOffset, 150, 25, "Stop Broadcast Sound", menu, instance.onOptionMouseDown)
    self.broadcastStopSoundButton.internal = "STOPBROADCAST"
    self.broadcastStopSoundButton:initialise()
    self.broadcastStopSoundButton:instantiate()
    menu:addChild(self.broadcastStopSoundButton)
	yOffset = yOffset + 35



	-------------------------

    self.cancel = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), menu, instance.onOptionMouseDown)
    self.cancel.internal = "CANCEL"
    self.cancel:initialise()
    self.cancel:instantiate()
    menu:addChild(self.cancel)
	
end

function PZRPGovOps_DataEntry:new(x, y, width, height, computer, govData)
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
	o.govData = govData
	o.permissions = "Access Denied"
    PZRPGovOps_DataEntry.instance = o
    return o
end

return PZRPGovOps_DataEntry