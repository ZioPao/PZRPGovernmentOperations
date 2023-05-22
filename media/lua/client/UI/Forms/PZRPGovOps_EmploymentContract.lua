local PZRPGovOps_EmploymentContract = {}

PZRPGovOps_EmploymentContract.CreateChildren = function(instance, yOffset)

	instance.mainLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Employment Contract")) / 2, yOffset, 25, "Employment Contract", 1, 1, 1, 1, UIFont.Large, true)
	instance:addChild(instance.mainLabel)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.employerEntry = ISTextEntryBox:new("Employer", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.employerEntry:initialise()
	instance.employerEntry:instantiate()
	instance.employerEntry:setOnlyNumbers(false)
	instance:addChild(instance.employerEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	instance.employeeEntry = ISTextEntryBox:new("Employee", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25)
	instance.employeeEntry:initialise()
	instance.employeeEntry:instantiate()
	instance.employeeEntry:setOnlyNumbers(false)
	instance:addChild(instance.employeeEntry)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    instance.conditionsLabel = ISLabel:new((instance.width - getTextManager():MeasureStringX(UIFont.Large, "Conditions of Contract")) / 2, yOffset, 25, "Conditions of Contract", 1, 1, 1, 1, UIFont.Large, true)
    instance:addChild(instance.conditionsLabel)
	yOffset = yOffset + 25

	instance.conditionsEntry = ISTextEntryBox:new("Conditions", PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 200)
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


