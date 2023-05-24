--***********************************************************
--**              	  ORBIT MODS                           **
--***********************************************************

require "DSE_Core"

PZRPGovOps_SoundsListViewer = ISPanel:derive("PZRPGovOps_SoundsListViewer")
PZRPGovOps_SoundsListViewer.messages = {}

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

-------------------------------------------------------------

function PZRPGovOps_SoundsListViewer:initialise()
    ISPanel.initialise(self)
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local padBottom = 10

    local top = 50
    self.panel = ISTabPanel:new(10, top, self.width - 10 * 2, self.height - padBottom - btnHgt - padBottom - top)
    self.panel:initialise()
    self.panel.borderColor = { r = 0, g = 0, b = 0, a = 0}
    self.panel.target = self
    self.panel.equalTabWidth = false
    self:addChild(self.panel)

    self.ok = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("IGUI_CraftUI_Close"), self, PZRPGovOps_SoundsListViewer.onClick)
    self.ok.internal = "CLOSE"
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise()
    self.ok:instantiate()
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1}
    self:addChild(self.ok)

    self:initList()
end

function PZRPGovOps_SoundsListViewer:initList()
    --self.module = {}
    --self.module["Sounds"] = {{1}, {2}}




    local mainCategory = PZRPGovOps_SoundsListTable:new(0, 0, self.panel.width, self.panel.height - self.panel.tabHeight, self)
    mainCategory:initialise()
    self.panel:addView("Sounds", mainCategory)
    self.panel:activateView("Sounds")
    mainCategory:initList(PZRP_GovOpsVars.broadcastSounds)

end

function PZRPGovOps_SoundsListViewer:prerender()
    local z = 20

    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)


    local title = "Sound Broadcast Manager"
    self:drawText(title, self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, title) / 2), z, 1,1,1,1, UIFont.Medium)
end

function PZRPGovOps_SoundsListViewer:onClick(button)
    if button.internal == "CLOSE" then
        self:close()
    end

end


function PZRPGovOps_SoundsListViewer:setKeyboardFocus()
    local view = self.panel:getActiveView()
    if not view then return end
    Core.UnfocusActiveTextEntryBox()
    --view.filterWidgetMap.Type:focus()
end

function PZRPGovOps_SoundsListViewer:close()
    self:setVisible(false)
    self:removeFromUIManager()
end

function PZRPGovOps_SoundsListViewer.OnOpenPanel()

    local modal = PZRPGovOps_SoundsListViewer:new(50, 200, 425, 700)
    modal:initialise()
    modal:addToUIManager()
    modal.instance:setKeyboardFocus()

    return modal
end

--************************************************************************--
--** PZRPGovOps_SoundsListViewer:new
--**
--************************************************************************--
function PZRPGovOps_SoundsListViewer:new(x, y, width, height)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2)
    y = getCore():getScreenHeight() / 2 - (height / 2)
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.width = width
    o.height = height
    o.moveWithMouse = true
    PZRPGovOps_SoundsListViewer.instance = o
    --ISDebugMenu.RegisterClass(self)
    return o
end
