require "ISUI/ISPanel"
PZRPGovOps_BroadcastMenu = ISPanel:derive("PZRPGovOps_BroadcastMenu")


function PZRPGovOps_BroadcastMenu:createChildren()
	local yOffset = 10
	local xPadding = 10


	self.mainLabel = ISLabel:new((self.width - getTextManager():MeasureStringX(UIFont.Large, "Audio Broadcast")) / 2, yOffset, 25, "Audio Broadcast", 1, 1, 1, 1, UIFont.Large, true)
	self:addChild(self.mainLabel)
	yOffset = yOffset + 30


    -- I don't have time to make it with a scrollbar without fucking something up.

    



	self.printBtn = ISButton:new(xPadding, yOffset, 150, 25, "PRINT", self, PZRPGovOps_BaseForm.onOptionMouseDown)
	self.printBtn.internal = "PRINT"
	self.printBtn:initialise()
	self.printBtn:instantiate()
	self:addChild(self.printBtn)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries

    -- TODO Make adjacent
	self.cancelBtn = ISButton:new(xPadding, yOffset, 150, 25, getText("UI_btn_close"), self, PZRPGovOps_BaseForm.onOptionMouseDown)
	self.cancelBtn.internal = "CANCEL"
	self.cancelBtn:initialise()
	self.cancelBtn:instantiate()
	self:addChild(self.cancelBtn)
	yOffset = yOffset + PZRP_GovOpsVars.distanceBetweenEntries


    self.model.CreateChildren(self, yOffset)

end

function PZRPGovOps_BroadcastMenu:onOptionMouseDown(button, _, _)
	if button.internal == "CANCEL" then
		self:close()
	elseif button.internal == "PRINT" and self.mainMenu.isPrinting == false then
        self.model.Print(self)

		local player = getPlayer()
		sendClientCommand(player, "PZRPGovOps", "StartSound", {sound = "PrintingDocument", x = player:getX(), y = player:getY(), z = player:getZ()})



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

function PZRPGovOps_BroadcastMenu:assignRemovalIndex(index)
	self.removalIndex = index
end
function PZRPGovOps_BroadcastMenu:close()
	self.mainMenu:removeOpenPanel(self.removalIndex, self:toString())
    self:setVisible(false)
    self:removeFromUIManager()
end

function PZRPGovOps_BroadcastMenu:new(x, y, width, height, mainMenu)
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
	return o
end