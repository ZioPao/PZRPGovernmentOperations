local PZRPGovOps_DriverLicense = ISPanel:derive("PZRPGovOps_DriverLicense")
require "lua_timers"

function PZRPGovOps_DriverLicense:createChildren()
	local yOffset = 10
	local xPadding = 10
	
	self.idform = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, "Driver's License")) / 2, yOffset, 25, "Driver's License", 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.idform)
	
	yOffset = yOffset + 35
	
	self.fullname = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
	self.fullname:initialise()
	self.fullname:instantiate()
	self.fullname:setOnlyNumbers(false)
	self:addChild(self.fullname)
	
	yOffset = yOffset + 35
	
	self.birthdate = ISTextEntryBox:new("Birth Date (MM/DD/YYYY)", xPadding, yOffset, 150, 25)
	self.birthdate:initialise()
	self.birthdate:instantiate()
	self.birthdate:setOnlyNumbers(false)
	self:addChild(self.birthdate)
	
	yOffset = yOffset + 35
	
	self.sexheader = ISLabel:new(xPadding, yOffset, 25, "Sex", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.sexheader)
	
	yOffset = yOffset + 25
	
	self.sex = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.sex:initialise()
	self.sex:addOption("M")
	self.sex:addOption("F")
	self:addChild(self.sex)
	
	yOffset = yOffset + 35
	
	self.eyeclrheader = ISLabel:new(xPadding, yOffset, 25, "Eye Clr", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.eyeclrheader)
	
	yOffset = yOffset + 25
	
	self.eyeclr = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.eyeclr:initialise()
	self.eyeclr:addOption("Bl")
	self.eyeclr:addOption("Br")
	self.eyeclr:addOption("Gr")
	self.eyeclr:addOption("Gy")
	self.eyeclr:addOption("HET")
	self:addChild(self.eyeclr)
	
	yOffset = yOffset + 35
	
	self.hairclrheader = ISLabel:new(xPadding, yOffset, 25, "Hair Clr", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.hairclrheader)
	
	yOffset = yOffset + 25
	
	self.hairclr = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.hairclr:initialise()
	self.hairclr:addOption("Aub")
	self.hairclr:addOption("Bld")
	self.hairclr:addOption("Blk")
	self.hairclr:addOption("Br")
	self.hairclr:addOption("Gn")
	self.hairclr:addOption("Rd")
	self.hairclr:addOption("Wh")
	self:addChild(self.hairclr)
	
	yOffset = yOffset + 35
	
	self.heightEntry = ISTextEntryBox:new("Height (feet)", xPadding, yOffset, 150, 25)
	self.heightEntry:initialise()
	self.heightEntry:instantiate()
	self.heightEntry:setOnlyNumbers(false)
	self:addChild(self.heightEntry)
	
	yOffset = yOffset + 35
	
	self.weight = ISTextEntryBox:new("Weight (pounds)", xPadding, yOffset, 150, 25)
	self.weight:initialise()
	self.weight:instantiate()
	self.weight:setOnlyNumbers(true)
	self:addChild(self.weight)
	
	yOffset = yOffset + 35
	
	self.classheader = ISLabel:new(xPadding, yOffset, 25, "Class", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.classheader)
	
	yOffset = yOffset + 25
	
	self.class = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.class:initialise()
	self.class:addOption("A")
	self.class:addOption("E")
	self:addChild(self.class)
	
	yOffset = yOffset + 35
	
	self.print = ISButton:new(xPadding, yOffset, 150, 25, "PRINT", self, PZRPGovOps_DriverLicense.onOptionMouseDown)
	self.print.internal = "PRINT"
	self.print:initialise()
	self.print:instantiate()
	self:addChild(self.print)

	yOffset = yOffset + 35
	
	self.cancelButton = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), self, PZRPGovOps_DriverLicense.onOptionMouseDown)
	self.cancelButton.internal = "CANCEL"
	self.cancelButton:initialise()
	self.cancelButton:instantiate()
	self:addChild(self.cancelButton)
end

function PZRPGovOps_DriverLicense:onOptionMouseDown(button, x, y)
	if button.internal == "CANCEL" then
		self:close()
	elseif button.internal == "PRINT" and self.mainMenu.isPrinting == false then
		self.mainMenu.isPrinting = true
		getSoundManager():PlayWorldSound("ccdeTypingLong", self.mainMenu.computer:getSquare(), 0, 8, 1, false)
		
		timer:Simple(3, function()
			getSoundManager():PlayWorldSound("ccdePrinting", self.mainMenu.computer:getSquare(), 0, 8, 1, false)
			
			timer:Simple(6, function()
				self:doPrint()
				self.mainMenu.isPrinting = false
			end)
		end)
		
		self:close()
	end
end

function PZRPGovOps_DriverLicense:doPrint()
	local form1 = InventoryItemFactory.CreateItem(".DrivingLicense")
	local form2 = InventoryItemFactory.CreateItem(".DrivingLicense")
	local formContents = "Birth Date: " .. tostring(self.birthdate:getText()) .. "\nSex: " .. tostring(self.sex:getSelectedText()) .. "\nEye Clr: " .. tostring(self.eyeclr:getSelectedText()) .. "\nHair Clr: " .. tostring(self.hairclr:getSelectedText()) .. "\nHeight: " .. tostring(self.heightEntry:getText()) .. "\nWeight: " .. tostring(self.weight:getText() .. " lbs" .. "\nClass: " .. tostring(self.class:getSelectedText()))
	
	form1:setName(tostring(self.fullname:getText()) .. " [DRI LIC]")
	form1:setCanBeWrite(true)
	form1:addPage(1, formContents)
	form1:setLockedBy(getPlayer():getUsername())
	
	form2:setName(tostring(self.fullname:getText()) .. " [DRI LIC]")
	form2:setCanBeWrite(true)
	form2:addPage(1, formContents)
	form2:setLockedBy(getPlayer():getUsername())

	getPlayer():getInventory():AddItem(form1)
	getPlayer():getInventory():AddItem(form2)
end

function PZRPGovOps_DriverLicense:render()

end

function PZRPGovOps_DriverLicense:assignRemovalIndex(index)
	self.removalIndex = index
end

function PZRPGovOps_DriverLicense:close()
	self.instance.mainMenu:removeOpenPanel(self.removalIndex, self:toString())
    self:setVisible(false)
    self:removeFromUIManager()
end

function PZRPGovOps_DriverLicense:new(x, y, width, height, mainMenu)
	local o = {}
	o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.variableColor = {r=0.9, g=0.55, b=0.1, a=1}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5}
	o.moveWithMouse = true
	o.mainMenu = mainMenu
	PZRPGovOps_DriverLicense.instance = o
	return o
end

return PZRPGovOps_DriverLicense
