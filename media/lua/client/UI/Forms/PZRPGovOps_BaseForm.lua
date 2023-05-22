require "ISUI/ISPanel"
PZRPGovOps_BaseForm = ISPanel:derive("PZRPGovOps_BaseForm")


function PZRPGovOps_BaseForm:createChildren()
	local yOffset = 10

	self.printBtn = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25, "PRINT", self, PZRPGovOps_BaseForm.onOptionMouseDown)
	self.printBtn.internal = "PRINT"
	self.printBtn:initialise()
	self.printBtn:instantiate()
	self:addChild(self.printBtn)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

	self.cancelBtn = ISButton:new(PZRP_GovOpsVars.xPadding, yOffset, PZRP_GovOpsVars.entryWidth, 25, getText("UI_btn_close"), self, PZRPGovOps_BaseForm.onOptionMouseDown)
	self.cancelBtn.internal = "CANCEL"
	self.cancelBtn:initialise()
	self.cancelBtn:instantiate()
	self:addChild(self.cancelBtn)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries


    self.model.CreateChildren(self, yOffset)

end

function PZRPGovOps_BaseForm:onOptionMouseDown(button, x, y)
	if button.internal == "CANCEL" then
		self:close()
	elseif button.internal == "PRINT" and self.mainMenu.isPrinting == false then
        self.model.Print(self)




		--self.mainMenu.isPrinting = true
		--getSoundManager():PlayWorldSound("ccdeTypingLong", self.mainMenu.computer:getSquare(), 0, 8, 1, false)
		
		--timer:Simple(3, function()
			--getSoundManager():PlayWorldSound("ccdePrinting", self.mainMenu.computer:getSquare(), 0, 8, 1, false)
			--timer:Simple(6, function()
				--self.mainMenu.isPrinting = false
			--end)
		--end)
		--self:close()
	end
end

function PZRPGovOps_BaseForm:assignRemovalIndex(index)
	self.removalIndex = index
end
function PZRPGovOps_BaseForm:close()
	self.mainMenu:removeOpenPanel(self.removalIndex, self:toString())
    self:setVisible(false)
    self:removeFromUIManager()
end

function PZRPGovOps_BaseForm:new(x, y, width, height, mainMenu, model)
	local o = {}
	o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
    o.width = width
    o.height = height


	o.variableColor = {r=0.9, g=0.55, b=0.1, a=1}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5}
	o.moveWithMouse = true
	o.mainMenu = mainMenu
    o.model = model
	return o
end