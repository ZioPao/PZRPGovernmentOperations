local PZRPGovOps_EditPermissions = ISPanel:derive("PZRPGovOps_EditPermissions")
local instance = nil


-- Strings (Modify them here, not in the function)
local MAIN_LABEL = PZRP_GovOpsVars.programName .. " (ADMIN)"
local PERMISSIONS_LABEL = "Permissions"
local USERNAME_ENTRY = "Username"
local IDENTIFICATION_ENTRY = "Identification Card"
local DRIVERSLICENSE_ENTRY = "Driver's License"
local MEDICALLICENSE_ENTRY = "Medical License"
local PROPERTYDEED_ENTRY = "Property Deed"
local VEHICLEREGISTRATION_ENTRY = "Vehicle Registration"
local EMPLOYMENTCONTRACT_ENTRY = "Employment Contract"
---------------------------------

function PZRPGovOps_EditPermissions:initialise()
	ISPanel.initialise(self)
    self:create()
end

function PZRPGovOps_EditPermissions:create()
	local xPadding = 10
	local yOffset = 10

	self.mainLabel = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, MAIN_LABEL)) / 2, yOffset, 25, MAIN_LABEL, 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.mainLabel)
	yOffset = yOffset + 35

	self.permissionsLabel = ISLabel:new(xPadding, yOffset, 25, PERMISSIONS_LABEL, 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.permissionsLabel)
	yOffset = yOffset + 25

	self.usernameEntry = ISTextEntryBox:new(USERNAME_ENTRY, xPadding, yOffset, 150, 25)
	self.usernameEntry:initialise()
	self.usernameEntry:instantiate()
	self.usernameEntry:setOnlyNumbers(false)
	self:addChild(self.usernameEntry)
	yOffset = yOffset + 25

	self.identificationCardEntry = ISTickBox:new(xPadding, yOffset, 25, 25, IDENTIFICATION_ENTRY)
	self.identificationCardEntry:initialise()
	self.identificationCardEntry:addOption(IDENTIFICATION_ENTRY, 1, nil)
	self:addChild(self.identificationCardEntry)
	yOffset = yOffset + 25

	self.driversLicenseEntry = ISTickBox:new(xPadding, yOffset, 25, 25, DRIVERSLICENSE_ENTRY)
	self.driversLicenseEntry:initialise()
	self.driversLicenseEntry:addOption(DRIVERSLICENSE_ENTRY, 1, nil)
	self:addChild(self.driversLicenseEntry)
	yOffset = yOffset + 25

	self.vehicleRegistrationEntry = ISTickBox:new(xPadding, yOffset, 25, 25, VEHICLEREGISTRATION_ENTRY)
	self.vehicleRegistrationEntry:initialise()
	self.vehicleRegistrationEntry:addOption(VEHICLEREGISTRATION_ENTRY, 1, nil)
	self:addChild(self.vehicleRegistrationEntry)
	yOffset = yOffset + 25

	self.propertyDeedEntry = ISTickBox:new(xPadding, yOffset, 25, 25, PROPERTYDEED_ENTRY)
	self.propertyDeedEntry:initialise()
	self.propertyDeedEntry:addOption(PROPERTYDEED_ENTRY, 1, nil)
	self:addChild(self.propertyDeedEntry)
	yOffset = yOffset + 25

	self.medicalLicenseEntry = ISTickBox:new(xPadding, yOffset, 25, 25, MEDICALLICENSE_ENTRY)
	self.medicalLicenseEntry:initialise()
	self.medicalLicenseEntry:addOption(MEDICALLICENSE_ENTRY, 1, nil)
	self:addChild(self.medicalLicenseEntry)
    yOffset = yOffset + 25

	self.employmentContractEntry = ISTickBox:new(xPadding, yOffset, 25, 25, EMPLOYMENTCONTRACT_ENTRY)
	self.employmentContractEntry:initialise()
	self.employmentContractEntry:addOption(EMPLOYMENTCONTRACT_ENTRY, 1, nil)
	self:addChild(self.employmentContractEntry)
    yOffset = yOffset + 25
    ----------------

    self.save = ISButton:new(xPadding, yOffset, 150, 25, "Save", self, PZRPGovOps_EditPermissions.onOptionMouseDown)
    self.save.internal = "SAVE"
    self.save:initialise()
    self.save:instantiate()
    self:addChild(self.save)
	yOffset = yOffset + 35

    self.cancel = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), self, PZRPGovOps_EditPermissions.onOptionMouseDown)
    self.cancel.internal = "CANCEL"
    self.cancel:initialise()
    self.cancel:instantiate()
    self:addChild(self.cancel)

    -- TODO Enable this
    --Events.OnPlayerMove.Add(OnPlayerMove)
end

function PZRPGovOps_EditPermissions:onOptionMouseDown(button, x, y)
	if button.internal == "CANCEL" then
		self:close()
	elseif button.internal == "SAVE" then
		local permissions = {}
		if self.identificationCardEntry:isSelected(1) then permissions.identificationCard = true else permissions.identificationCard = false end
		if self.driversLicenseEntry:isSelected(1) then permissions.driversLicense = true else permissions.driversLicense = false end
		if self.propertyDeedEntry:isSelected(1) then permissions.propertyDeed = true else permissions.propertyDeed = false end
		if self.vehicleRegistrationEntry:isSelected(1) then permissions.vehicleRegistration = true else permissions.vehicleRegistration = false end
		if self.medicalLicenseEntry:isSelected(1) then permissions.medicalLicense = true else permissions.medicalLicense = false end
		if self.employmentContractEntry:isSelected(1) then permissions.employmentContract = true else permissions.employmentContract = false end

		sendClientCommand(getPlayer(), "PZRPGovOps", "SavePermissions", {username = self.usernameEntry:getText(), permissions = permissions})
		self:close()
	end
end




--********************************************--
function PZRPGovOps_EditPermissions:new(x, y, width, height, computer, ccdeData, access)
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
	o.ccdeData = ccdeData
	o.access = access
    PZRPGovOps_EditPermissions.instance = o
    return o
end

return PZRPGovOps_EditPermissions