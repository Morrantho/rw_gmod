local PANEL = {}

function PANEL:CalcValues()
    local player = LocalPlayer()
    self.value = player:Health()
    self.max = player:GetMaxHealth() 
end

ui.add("cl_ui_health", PANEL, "cl_bar_base")