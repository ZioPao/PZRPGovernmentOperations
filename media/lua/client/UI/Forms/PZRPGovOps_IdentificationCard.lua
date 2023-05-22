local PZRPGovOps_IdentificationCard = {}

function PZRPGovOps_IdentificationCard.CreateChildren(instance, yOffset)
	local xPadding = 10

	instance.idform = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Identification")) / 2, yOffset, 25, "Identification", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.idform)
	yOffset = yOffset + 35
	
	instance.fullNameEntry = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
	instance.fullNameEntry:initialise()
	instance.fullNameEntry:instantiate()
	instance.fullNameEntry:setOnlyNumbers(false)
	instance:addChild(instance.fullNameEntry)
	yOffset = yOffset + 35
	
	instance.birthdateEntry = ISTextEntryBox:new("Birth Date (MM/DD/YYYY)", xPadding, yOffset, 150, 25)
	instance.birthdateEntry:initialise()
	instance.birthdateEntry:instantiate()
	instance.birthdateEntry:setOnlyNumbers(false)
	instance:addChild(instance.birthdateEntry)
	yOffset = yOffset + 35
	
	instance.sexLabel = ISLabel:new(xPadding, yOffset, 25, "Sex", 1, 1, 1, 1, UIFont.Medium, true)
	instance:addChild(instance.sexLabel)
	yOffset = yOffset + 25
	
	instance.sexEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	instance.sexEntry:initialise()
	instance.sexEntry:addOption("M")
	instance.sexEntry:addOption("F")
	instance:addChild(instance.sexEntry)
	yOffset = yOffset + 35
	
	instance.eyeColorLabel = ISLabel:new(xPadding, yOffset, 25, "Eye Clr", 1, 1, 1, 1, UIFont.Medium, true)
	instance:addChild(instance.eyeColorLabel)
	yOffset = yOffset + 25
	
	instance.eyeColorEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	instance.eyeColorEntry:initialise()
	instance.eyeColorEntry:addOption("Bl")
	instance.eyeColorEntry:addOption("Br")
	instance.eyeColorEntry:addOption("Gr")
	instance.eyeColorEntry:addOption("Gy")
	instance.eyeColorEntry:addOption("HET")
	instance:addChild(instance.eyeColorEntry)
	yOffset = yOffset + 35
	
	instance.hairColorLabel = ISLabel:new(xPadding, yOffset, 25, "Hair Clr", 1, 1, 1, 1, UIFont.Medium, true)
	instance:addChild(instance.hairColorLabel)
	yOffset = yOffset + 25
	
	instance.hairColorEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	instance.hairColorEntry:initialise()
	instance.hairColorEntry:addOption("Aub")
	instance.hairColorEntry:addOption("Bld")
	instance.hairColorEntry:addOption("Blk")
	instance.hairColorEntry:addOption("Br")
	instance.hairColorEntry:addOption("Gn")
	instance.hairColorEntry:addOption("Rd")
	instance.hairColorEntry:addOption("Wh")
	instance:addChild(instance.hairColorEntry)
	yOffset = yOffset + 35
	
	instance.heightEntry = ISTextEntryBox:new("Height (feet)", xPadding, yOffset, 150, 25)
	instance.heightEntry:initialise()
	instance.heightEntry:instantiate()
	instance.heightEntry:setOnlyNumbers(false)
	instance:addChild(instance.heightEntry)
	yOffset = yOffset + 35
	
	instance.weightEntry = ISTextEntryBox:new("Weight (pounds)", xPadding, yOffset, 150, 25)
	instance.weightEntry:initialise()
	instance.weightEntry:instantiate()
	instance.weightEntry:setOnlyNumbers(true)
	instance:addChild(instance.weightEntry)
	yOffset = yOffset + 35
	
	instance.printBtn = ISButton:new(xPadding, yOffset, 150, 25, "PRINT", instance, PZRPGovOps_IdentificationCard.onOptionMouseDown)
	instance.printBtn.internal = "PRINT"
	instance.printBtn:initialise()
	instance.printBtn:instantiate()
	instance:addChild(instance.printBtn)
	yOffset = yOffset + 35
	
	instance.cancelBtn = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), instance, PZRPGovOps_IdentificationCard.onOptionMouseDown)
	instance.cancelBtn.internal = "CANCEL"
	instance.cancelBtn:initialise()
	instance.cancelBtn:instantiate()
	instance:addChild(instance.cancelBtn)
end
function PZRPGovOps_IdentificationCard.Print(instance)
    local title = tostring(instance.fullNameEntry:getText()) .. " [ID]"
    local contents = "Birth Date: " .. tostring(instance.birthdateEntry:getText()) .. "\nSex: " .. tostring(instance.sexEntry:getSelectedText()) .. "\nEye Clr: " .. tostring(instance.eyeColorEntry:getSelectedText()) .. "\nHair Clr: " .. tostring(instance.hairColorEntry:getSelectedText()) .. "\nHeight: " .. tostring(instance.heightEntry:getText()) .. "\nWeight: " .. tostring(instance.weightEntry:getText() .. " lbs")
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.IdentificationCard", title, contents)
end

return PZRPGovOps_IdentificationCard