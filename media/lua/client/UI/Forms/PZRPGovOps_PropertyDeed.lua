local PZRPGovOps_PropertyDeed = {}

PZRPGovOps_PropertyDeed.CreateChildren = function(instance, yOffset)
	local xPadding = 10

	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Property Deed")) / 2, yOffset, 25, "Property Deed", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + 35

	instance.fullnameEntry = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
	instance.fullnameEntry:initialise()
	instance.fullnameEntry:instantiate()
	instance.fullnameEntry:setOnlyNumbers(false)
	instance:addChild(instance.fullnameEntry)
	yOffset = yOffset + 35

	instance.locationEntry = ISTextEntryBox:new("Location Name", xPadding, yOffset, 150, 25)
	instance.locationEntry:initialise()
	instance.locationEntry:instantiate()
	instance.locationEntry:setOnlyNumbers(false)
	instance:addChild(instance.locationEntry)
	yOffset = yOffset + 35

	instance.addressEntry = ISTextEntryBox:new("Address Number/Street", xPadding, yOffset, 150, 25)
	instance.addressEntry:initialise()
	instance.addressEntry:instantiate()
	instance.addressEntry:setOnlyNumbers(false)
	instance:addChild(instance.addressEntry)

end

PZRPGovOps_PropertyDeed.Print = function(instance)
    local title = "Original Property Deed of " .. tostring(instance.locationEntry:getText())
	local contents = "The Property of " .. tostring(instance.locationEntry:getText()) ..
		",\nLocated on " .. tostring(instance.addressEntry:getText()) .. ", Kentucky" ..
		"\nHereby belongs to\n\n" .. tostring(instance.fullnameEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.PropertyDeed", title, contents)
end

return PZRPGovOps_PropertyDeed