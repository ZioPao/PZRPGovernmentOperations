local PZRPGovOps_MedicalLicense = {}

PZRPGovOps_MedicalLicense.CreateChildren = function(instance, yOffset)
    local xPadding = 10

    instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Med. Lic. Form")) / 2, yOffset, 25, "Med. Lic. Form", 1, 1, 1, 1, UIFont.Large, true)
    instance:addChild(instance.mainLabel)
    yOffset = yOffset + 35

    instance.fullnameEntry = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
    instance.fullnameEntry:initialise()
    instance.fullnameEntry:instantiate()
    instance.fullnameEntry:setOnlyNumbers(false)
    instance:addChild(instance.fullnameEntry)
    yOffset = yOffset + 35

    instance.birthdayEntry = ISTextEntryBox:new("Birth Date (MM/DD/YYYY)", xPadding, yOffset, 150, 25)
    instance.birthdayEntry:initialise()
    instance.birthdayEntry:instantiate()
    instance.birthdayEntry:setOnlyNumbers(true)
    instance:addChild(instance.birthdayEntry)
    yOffset = yOffset + 35

    instance.addressEntry = ISTextEntryBox:new("Address", xPadding, yOffset, 150, 25)
    instance.addressEntry:initialise()
    instance.addressEntry:instantiate()
    instance.addressEntry:setOnlyNumbers(false)
    instance:addChild(instance.addressEntry)
    yOffset = yOffset + 35

    instance.cityEntry = ISTextEntryBox:new("City", xPadding, yOffset, 150, 25)
    instance.cityEntry:initialise()
    instance.cityEntry:instantiate()
    instance.cityEntry:setOnlyNumbers(false)
    instance:addChild(instance.cityEntry)
    yOffset = yOffset + 35

    instance.stateEntry = ISTextEntryBox:new("State", xPadding, yOffset, 150, 25)
    instance.stateEntry:initialise()
    instance.stateEntry:instantiate()
    instance.stateEntry:setOnlyNumbers(false)
    instance:addChild(instance.stateEntry)
    yOffset = yOffset + 35

    instance.usCitizenLabel = ISLabel:new(xPadding, yOffset, 25, "US Citizen/Perm. Res.?", 1, 1, 1, 1, UIFont.Medium, true)
    instance:addChild(instance.usCitizenLabel)
    yOffset = yOffset + 25

    instance.usCitizenEntry = ISTickBox:new(xPadding, yOffset, 25, 25, "US Citizen/Perm. Res.?")
    instance.usCitizenEntry:initialise()
    instance.usCitizenEntry:instantiate()
	instance.usCitizenEntry:addOption("Yes", 1, nil)
    instance.usCitizenEntry:addOption("No", 2, nil)
    instance:addChild(instance.usCitizenEntry)
    yOffset = yOffset + 45
    
    instance.fieldEntry = ISTextEntryBox:new("Field of Practice", xPadding, yOffset, 150, 25)
    instance.fieldEntry:initialise()
    instance.fieldEntry:instantiate()
    instance.fieldEntry:setOnlyNumbers(false)
    instance:addChild(instance.fieldEntry)
    yOffset = yOffset + 35

    instance.schoolEntry = ISTextEntryBox:new("Medical School", xPadding, yOffset, 150, 25)
    instance.schoolEntry:initialise()
    instance.schoolEntry:instantiate()
    instance.schoolEntry:setOnlyNumbers(false)
    instance:addChild(instance.schoolEntry)
    yOffset = yOffset + 35
    
    instance.graduationEntry = ISTextEntryBox:new("Graduation Year", xPadding, yOffset, 150, 25)
    instance.graduationEntry:initialise()
    instance.graduationEntry:instantiate()
    instance.graduationEntry:setOnlyNumbers(false)
    instance:addChild(instance.graduationEntry)
    yOffset = yOffset + 35
    
    instance.expiryEntry = ISTextEntryBox:new("Expiry Date (MM/DD/YYYY)", xPadding, yOffset, 150, 25)
    instance.expiryEntry:initialise()
    instance.expiryEntry:instantiate()
    instance.expiryEntry:setOnlyNumbers(false)
    instance:addChild(instance.expiryEntry)

end

PZRPGovOps_MedicalLicense.Print = function(instance)
	local title = tostring(instance.fullname:getText()) .. " [MED LIC]"
    local contents = "Full Name: " .. tostring(instance.fullname:getText()) .. "\nBirth Date: " .. tostring(instance.dob:getText()) .. "\nAddress: " .. tostring(instance.address:getText()) .. "\nCity: " .. tostring(instance.city:getText()) .. "\nState: " .. tostring(instance.state:getText()) .. "\nU.S. Citizen or Permanent Resident: " .. (instance.usCitizen:isSelected(1) and "Yes" or "No") .. "\nField of Practice: " .. tostring(instance.field:getText()) .. "\nMedical School: " .. tostring(instance.school:getText()) .. "\nGraduation Year: " .. tostring(instance.graduation:getText()) .. "\nExpiry Date: " .. tostring(instance.expiry:getText()) .. "\nLicense ID: #" .. licenseID
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.MedicalLicense", title, contents)
end

return PZRPGovOps_MedicalLicense