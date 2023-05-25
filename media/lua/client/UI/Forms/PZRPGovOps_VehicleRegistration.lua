local PZRPGovOps_VehicleRegistration = {}

PZRPGovOps_VehicleRegistration.CreateChildren = function(instance, yOffset)
	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Vehicle Registration")) / 2, yOffset, 25, "Vehicle Registration", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + 35

	instance.ownerEntry = ISTextEntryBox:new("Registered Owner", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.ownerEntry:initialise()
	instance.ownerEntry:instantiate()
	instance.ownerEntry:setOnlyNumbers(false)
	instance:addChild(instance.ownerEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.makeEntry = ISTextEntryBox:new("Make", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.makeEntry:initialise()
	instance.makeEntry:instantiate()
	instance.makeEntry:setOnlyNumbers(false)
	instance:addChild(instance.makeEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.modelEntry = ISTextEntryBox:new("Model", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.modelEntry:initialise()
	instance.modelEntry:instantiate()
	instance.modelEntry:setOnlyNumbers(false)
	instance:addChild(instance.modelEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.yearEntry = ISTextEntryBox:new("Year", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.yearEntry:initialise()
	instance.yearEntry:instantiate()
	instance.yearEntry:setOnlyNumbers(false)
	instance:addChild(instance.yearEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.colorEntry = ISTextEntryBox:new("Color", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.colorEntry:initialise()
	instance.colorEntry:instantiate()
	instance.colorEntry:setOnlyNumbers(false)
	instance:addChild(instance.colorEntry)

end

PZRPGovOps_VehicleRegistration.Print = function(instance)
	local title = tostring(instance.ownerEntry:getText()) .. " [VR]"
	local contents = "Color: " .. tostring(instance.colorEntry:getText()) ..
		"\nMake: " .. tostring(instance.makeEntry:getText()) ..
		"\nModel:" .. tostring(instance.modelEntry:getText()) ..
		"\nYear: " .. tostring(instance.yearEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.VehicleRegistration", title, contents)
end

return PZRPGovOps_VehicleRegistration