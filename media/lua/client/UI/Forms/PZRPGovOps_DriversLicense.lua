local PZRPGovOps_DriversLicense = {}

PZRPGovOps_DriversLicense.CreateChildren = function (instance, yOffset)

	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Driver's License")) / 2, yOffset, 25, "Driver's License", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.fullnameEntry = ISTextEntryBox:new("Full Name", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.fullnameEntry:initialise()
	instance.fullnameEntry:instantiate()
	instance.fullnameEntry:setOnlyNumbers(false)
	instance:addChild(instance.fullnameEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.birthdateEntry = ISTextEntryBox:new("Birth Date (MM/DD/YYYY)", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.birthdateEntry:initialise()
	instance.birthdateEntry:instantiate()
	instance.birthdateEntry:setOnlyNumbers(false)
	instance:addChild(instance.birthdateEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.issuedEntry = ISTextEntryBox:new("Issued (MM/DD/YYYY)", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.issuedEntry:initialise()
	instance.issuedEntry:instantiate()
	instance.issuedEntry:setOnlyNumbers(false)
	instance:addChild(instance.issuedEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries


	instance.expirationEntry = ISTextEntryBox:new("Expiration (MM/DD/YYYY)", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.expirationEntry:initialise()
	instance.expirationEntry:instantiate()
	instance.expirationEntry:setOnlyNumbers(false)
	instance:addChild(instance.expirationEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries


	instance.heightEntry = ISTextEntryBox:new("Height (feet)", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.heightEntry:initialise()
	instance.heightEntry:instantiate()
	instance.heightEntry:setOnlyNumbers(false)
	instance:addChild(instance.heightEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.eyeColorLabel = ISLabel:new(PZRP_GovOpsVars.xPadding, yOffset, 25, "Eye Clr", 1, 1, 1, 1, UIFont.Medium, true)
	instance:addChild(instance.eyeColorLabel)
	yOffset = yOffset + 25

	instance.eyeColorEntry = ISComboBox:new(PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.eyeColorEntry:initialise()
	instance.eyeColorEntry:addOption("Bl")
	instance.eyeColorEntry:addOption("Br")
	instance.eyeColorEntry:addOption("Gr")
	instance.eyeColorEntry:addOption("Gy")
	instance.eyeColorEntry:addOption("HET")
	instance:addChild(instance.eyeColorEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.classLabel = ISLabel:new(PZRP_GovOpsVars.xPadding, yOffset, 25, "Class", 1, 1, 1, 1, UIFont.Medium, true)
	instance:addChild(instance.classLabel)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.classEntry = ISComboBox:new(PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.classEntry:initialise()
	instance.classEntry:addOption("A")
	instance.classEntry:addOption("E")
	instance:addChild(instance.classEntry)

end

PZRPGovOps_DriversLicense.Print = function(instance)
	local title = tostring(instance.fullnameEntry:getText()) .. " [DRI LIC]"
	local contents = "Birth Date: " .. tostring(instance.birthdateEntry:getText()) ..
		"\nIssued: " .. tostring(instance.issuedEntry:getText()) ..
		"\nExpiration: " .. tostring(instance.expirationEntry:getText()) ..
		"\nHeight: " .. tostring(instance.heightEntry:getText()) ..
		"\nEye Clr: " .. tostring(instance.eyeColorEntry:getSelectedText()) ..
		"\nClass: " .. tostring(instance.classEntry:getSelectedText())

	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.DrivingLicense", title, contents)
end

return PZRPGovOps_DriversLicense