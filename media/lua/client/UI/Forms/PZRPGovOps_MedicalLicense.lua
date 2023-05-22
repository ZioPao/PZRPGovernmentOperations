local PZRPGovOps_MedicalLicense = {}

PZRPGovOps_MedicalLicense.CreateChildren = function(instance, yOffset)
    instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Med. Lic. Form")) / 2, yOffset, 25, "Med. Lic. Form", 1, 1, 1, 1, UIFont.Large, true)
    instance:addChild(instance.mainLabel)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    instance.fullnameEntry = ISTextEntryBox:new("Full Name", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
    instance.fullnameEntry:initialise()
    instance.fullnameEntry:instantiate()
    instance.fullnameEntry:setOnlyNumbers(false)
    instance:addChild(instance.fullnameEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    instance.licenseNumberEntry = ISTextEntryBox:new("License Number", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
    instance.licenseNumberEntry:initialise()
    instance.licenseNumberEntry:instantiate()
    instance.licenseNumberEntry:setOnlyNumbers(true)
    instance:addChild(instance.licenseNumberEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    instance.expirationEntry = ISTextEntryBox:new("Expiration(MM/DD/YYYY)", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
    instance.expirationEntry:initialise()
    instance.expirationEntry:instantiate()
    instance.expirationEntry:setOnlyNumbers(true)
    instance:addChild(instance.expirationEntry)

end

PZRPGovOps_MedicalLicense.Print = function(instance)
	local title = tostring(instance.fullnameEntry:getText()) .. " [MED LIC]"
    local contents = "Full Name: " .. tostring(instance.fullnameEntry:getText()) ..
        "\nLicense Number: " .. tostring(instance.licenseNumberEntry:getText()) ..
        "\nExpiration Date: " .. tostring(instance.expirationEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.MedicalLicense", title, contents)
end

return PZRPGovOps_MedicalLicense