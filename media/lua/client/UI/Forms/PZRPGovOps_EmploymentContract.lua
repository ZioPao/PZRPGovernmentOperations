local PZRPGovOps_EmploymentContract = {}

PZRPGovOps_EmploymentContract.CreateChildren = function(instance, yOffset)
	local xPadding = 10

	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Employment Contract")) / 2, yOffset, 25, "Employment Contract", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + 35

	instance.employerEntry = ISTextEntryBox:new("Employer", xPadding, yOffset, 150, 25)
	instance.employerEntry:initialise()
	instance.employerEntry:instantiate()
	instance.employerEntry:setOnlyNumbers(false)
	instance:addChild(instance.employerEntry)
	yOffset = yOffset + 35

	instance.employeeEntry = ISTextEntryBox:new("Employee", xPadding, yOffset, 150, 25)
	instance.employeeEntry:initialise()
	instance.employeeEntry:instantiate()
	instance.employeeEntry:setOnlyNumbers(false)
	instance:addChild(instance.employeeEntry)
	yOffset = yOffset + 35


    instance.conditionsLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Conditions of Contract")) / 2, yOffset, 25, "Conditions of COntract", 1, 1, 1, 1, UIFont.Large, true)
    instance:addChild(instance.conditionsLabel)

    yOffset = yOffset + 35
	instance.conditionsEntry = ISTextEntryBox:new("Conditions", xPadding, yOffset, 150, 200)
	instance.conditionsEntry:initialise()
	instance.conditionsEntry:instantiate()
	instance.conditionsEntry:setOnlyNumbers(false)
	instance:addChild(instance.conditionsEntry)

end

PZRPGovOps_EmploymentContract.Print = function(instance)
    local title = tostring(instance.employerEntry:getText()) .. " - " .. tostring(instance.employeeEntry:getText()) .. " - Employment Contract"
	local contents = "The following contract confirms the working relationship between " .. 
    tostring(instance.employeeEntry:getText()) .. " and " .. tostring(instance.employeeEntry:getText()) ..
    "according to the following conditions: \n" .. tostring(instance.conditionsEntry:getText())
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.PropertyDeed", title, contents)
end

return PZRPGovOps_EmploymentContract


