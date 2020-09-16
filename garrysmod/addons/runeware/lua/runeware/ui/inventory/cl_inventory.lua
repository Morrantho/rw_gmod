if !ui.enabled then return; end
local PANEL = {}
local PARENT

function PANEL:Init()
    PARENT = vgui.GetControlTable("cl_itempanel")
    PARENT.Init(self)

    
end

ui.add("cl_inventory", PANEL, "cl_itempanel")