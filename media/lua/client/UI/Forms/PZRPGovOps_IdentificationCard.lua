local PZRPGovOps_IdentificationCard = ISPanel:derive("PZRPGovOps_IdentificationCard")
require "lua_timers"

function PZRPGovOps_IdentificationCard:createChildren()
	local yOffset = 10
	local xPadding = 10
	
	self.idform = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, "Identification")) / 2, yOffset, 25, "Identification", 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.idform)
	
	yOffset = yOffset + 35
	
	self.fullNameEntry = ISTextEntryBox:new("Full Name", xPadding, yOffset, 150, 25)
	self.fullNameEntry:initialise()
	self.fullNameEntry:instantiate()
	self.fullNameEntry:setOnlyNumbers(false)
	self:addChild(self.fullNameEntry)
	
	yOffset = yOffset + 35
	
	self.birthdateEntry = ISTextEntryBox:new("Birth Date (MM/DD/YYYY)", xPadding, yOffset, 150, 25)
	self.birthdateEntry:initialise()
	self.birthdateEntry:instantiate()
	self.birthdateEntry:setOnlyNumbers(false)
	self:addChild(self.birthdateEntry)
	
	yOffset = yOffset + 35
	
	self.sexLabel = ISLabel:new(xPadding, yOffset, 25, "Sex", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.sexLabel)
	
	yOffset = yOffset + 25
	
	self.sexEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.sexEntry:initialise()
	self.sexEntry:addOption("M")
	self.sexEntry:addOption("F")
	self:addChild(self.sexEntry)
	
	yOffset = yOffset + 35
	
	self.eyeColorLabel = ISLabel:new(xPadding, yOffset, 25, "Eye Clr", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.eyeColorLabel)
	
	yOffset = yOffset + 25
	
	self.eyeColorEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.eyeColorEntry:initialise()
	self.eyeColorEntry:addOption("Bl")
	self.eyeColorEntry:addOption("Br")
	self.eyeColorEntry:addOption("Gr")
	self.eyeColorEntry:addOption("Gy")
	self.eyeColorEntry:addOption("HET")
	self:addChild(self.eyeColorEntry)
	
	yOffset = yOffset + 35
	
	self.hairColorLabel = ISLabel:new(xPadding, yOffset, 25, "Hair Clr", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(self.hairColorLabel)
	
	yOffset = yOffset + 25
	
	self.hairColorEntry = ISComboBox:new(xPadding, yOffset, 150, 25)
	self.hairColorEntry:initialise()
	self.hairColorEntry:addOption("Aub")
	self.hairColorEntry:addOption("Bld")
	self.hairColorEntry:addOption("Blk")
	self.hairColorEntry:addOption("Br")
	self.hairColorEntry:addOption("Gn")
	self.hairColorEntry:addOption("Rd")
	self.hairColorEntry:addOption("Wh")
	self:addChild(self.hairColorEntry)
	
	yOffset = yOffset + 35
	
	self.heightEntry = ISTextEntryBox:new("Height (feet)", xPadding, yOffset, 150, 25)
	self.heightEntry:initialise()
	self.heightEntry:instantiate()
	self.heightEntry:setOnlyNumbers(false)
	self:addChild(self.heightEntry)
	
	yOffset = yOffset + 35
	
	self.weightEntry = ISTextEntryBox:new("Weight (pounds)", xPadding, yOffset, 150, 25)
	self.weightEntry:initialise()
	self.weightEntry:instantiate()
	self.weightEntry:setOnlyNumbers(true)
	self:addChild(self.weightEntry)
	
	yOffset = yOffset + 35
	
	self.printBtn = ISButton:new(xPadding, yOffset, 150, 25, "PRINT", self, PZRPGovOps_IdentificationCard.onOptionMouseDown)
	self.printBtn.internal = "PRINT"
	self.printBtn:initialise()
	self.printBtn:instantiate()
	self:addChild(self.printBtn)

	yOffset = yOffset + 35
	
	self.cancelBtn = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), self, PZRPGovOps_IdentificationCard.onOptionMouseDown)
	self.cancelBtn.internal = "CANCEL"
	self.cancelBtn:initialise()
	self.cancelBtn:instantiate()
	self:addChild(self.cancelBtn)
end

function PZRPGovOps_IdentificationCard:onOptionMouseDown(button, x, y)
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

function PZRPGovOps_IdentificationCard:doPrint()
    local title = tostring(self.fullNameEntry:getText()) .. " [ID]"
    local contents = "Birth Date: " .. tostring(self.birthdateEntry:getText()) .. "\nSex: " .. tostring(self.sexEntry:getSelectedText()) .. "\nEye Clr: " .. tostring(self.eyeColorEntry:getSelectedText()) .. "\nHair Clr: " .. tostring(self.hairColorEntry:getSelectedText()) .. "\nHeight: " .. tostring(self.heightEntry:getText()) .. "\nWeight: " .. tostring(self.weightEntry:getText() .. " lbs")
	PZRP_GovOpsMain.PrintDocumentAndCopy("Base.IdentificationCard", title, contents)
end


function PZRPGovOps_IdentificationCard:assignRemovalIndex(index)
	self.removalIndex = index
end

function PZRPGovOps_IdentificationCard:close()
	self.instance.mainMenu:removeOpenPanel(self.removalIndex, self:toString())
	self:setVisible(false)
	self:removeFromUIManager()
end

--*****************************************--

function PZRPGovOps_IdentificationCard:new(x, y, width, height, mainMenu)
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
	PZRPGovOps_IdentificationCard.instance = o
	return o
end

return PZRPGovOps_IdentificationCard
