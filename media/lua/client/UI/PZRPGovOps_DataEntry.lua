local PZRPGovOps_DataEntry = ISPanel:derive("PZRPGovOps_DataEntry")


function PZRPGovOps_DataEntry:new(x, y, width, height, computer, govData)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1}
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5}
    o.moveWithMouse = true
    o.computer = computer
	o.govData = govData
	o.permissions = "Access Denied"
    PZRPGovOps_DataEntry.instance = o
    return o
end

return PZRPGovOps_DataEntry