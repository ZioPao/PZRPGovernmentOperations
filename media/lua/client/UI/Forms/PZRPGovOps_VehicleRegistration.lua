local PZRPGovOps_VehicleRegistration = {}

PZRPGovOps_VehicleRegistration.CreateChildren = function(instance, yOffset)
	local xPadding = 10

	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Vehicle Registration")) / 2, yOffset, 25, "Vehicle Registration", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + 35

	instance.ownerEntry = ISTextEntryBox:new("Registered Owner", xPadding, yOffset, 150, 25)
	instance.ownerEntry:initialise()
	instance.ownerEntry:instantiate()
	instance.ownerEntry:setOnlyNumbers(false)
	instance:addChild(instance.ownerEntry)
	yOffset = yOffset + 35

	instance.makeEntry = ISTextEntryBox:new("Make", xPadding, yOffset, 150, 25)
	instance.makeEntry:initialise()
	instance.makeEntry:instantiate()
	instance.makeEntry:setOnlyNumbers(false)
	instance:addChild(instance.makeEntry)
	yOffset = yOffset + 35

	instance.modelEntry = ISTextEntryBox:new("Model", xPadding, yOffset, 150, 25)
	instance.modelEntry:initialise()
	instance.modelEntry:instantiate()
	instance.modelEntry:setOnlyNumbers(false)
	instance:addChild(instance.modelEntry)
	yOffset = yOffset + 35

	instance.yearEntry = ISTextEntryBox:new("Year", xPadding, yOffset, 150, 25)
	instance.yearEntry:initialise()
	instance.yearEntry:instantiate()
	instance.yearEntry:setOnlyNumbers(false)
	instance:addChild(instance.yearEntry)
	yOffset = yOffset + 35

	instance.colorEntry = ISTextEntryBox:new("Color", xPadding, yOffset, 150, 25)
	instance.colorEntry:initialise()
	instance.colorEntry:instantiate()
	instance.colorEntry:setOnlyNumbers(false)
	instance:addChild(instance.colorEntry)

end

PZRPGovOps_VehicleRegistration.Print = function(instance)
	local title = tostring(instance.ownerEntry:getText()) .. " [VEH REG]"
	local contents = "Color: " .. tostring(instance.colorEntry:getText()) ..
		"\nMake: " .. tostring(instance.makeEntry:getText()) ..
		"\nModel:" .. tostring(instance.modelEntry:getText()) ..
		"\nYear: " .. tostring(instance.yearEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.VehicleRegistration", title, contents)
end

return PZRPGovOps_VehicleRegistration