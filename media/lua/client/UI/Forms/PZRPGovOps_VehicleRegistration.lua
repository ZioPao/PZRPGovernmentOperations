local PZRPGovOps_VehicleRegistration = {}

function PZRPGovOps_VehicleRegistration.CreateChildren(instance, yOffset)
	local xPadding = 10

	instance.idform = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Vehicle Registration")) / 2, yOffset, 25, "Vehicle Registration", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.idform)
	yOffset = yOffset + 35

	instance.fullnameEntry = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
	instance.fullnameEntry:initialise()
	instance.fullnameEntry:instantiate()
	instance.fullnameEntry:setOnlyNumbers(false)
	instance:addChild(instance.fullnameEntry)
	yOffset = yOffset + 35
	
	instance.platesEntry = ISTextEntryBox:new("Plates", xPadding, yOffset, 150, 25)
	instance.platesEntry:initialise()
	instance.platesEntry:instantiate()
	instance.platesEntry:setOnlyNumbers(false)
	instance:addChild(instance.platesEntry)
	
	yOffset = yOffset + 35
	
	instance.colorEntry = ISTextEntryBox:new("Color", xPadding, yOffset, 150, 25)
	instance.colorEntry:initialise()
	instance.colorEntry:instantiate()
	instance.colorEntry:setOnlyNumbers(false)
	instance:addChild(instance.colorEntry)
	
	yOffset = yOffset + 35
	
	instance.makerEntry = ISTextEntryBox:new("Maker", xPadding, yOffset, 150, 25)
	instance.makerEntry:initialise()
	instance.makerEntry:instantiate()
	instance.makerEntry:setOnlyNumbers(false)
	instance:addChild(instance.makerEntry)
	
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
	
	instance.printBtn = ISButton:new(xPadding, yOffset, 150, 25, "PRINT", instance, PZRPGovOps_VehicleRegistration.onOptionMouseDown)
	instance.printBtn.internal = "PRINT"
	instance.printBtn:initialise()
	instance.printBtn:instantiate()
	instance:addChild(instance.printBtn)

	yOffset = yOffset + 35
	
	instance.cancelButton = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), instance, PZRPGovOps_VehicleRegistration.onOptionMouseDown)
	instance.cancelButton.internal = "CANCEL"
	instance.cancelButton:initialise()
	instance.cancelButton:instantiate()
	instance:addChild(instance.cancelButton)
end
function PZRPGovOps_VehicleRegistration.Print(instance)
	local title = tostring(instance.fullnameEntry:getText()) .. " [VEH REG]"
	local contents = "Color: " .. tostring(instance.colorEntry:getText()) .. "\nPlates: " .. tostring(instance.platesEntry:getText()) .. "\nMake: " .. tostring(instance.makerEntry:getText()) .. "\nModel:" .. tostring(instance.modelEntry:getText()) .. "\nYear: " .. tostring(instance.yearEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.VehicleRegistration", title, contents)
end

return PZRPGovOps_VehicleRegistration
