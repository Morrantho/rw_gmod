local function init()
    local scrw = ScrW()
    local scrh = ScrH()

    hud.health = vgui.Create("cl_ui_health")
    hud.health:SetPos(scrw * .10, scrh * .95)
    hud.health:SetSize(scrw * .20, scrh * .04)
end

if hud then 
    for k, v in pairs(hud) do 
        v:Remove()
    end
    init()
end 

hud = hud or {} 

--hook.Add("InitPostEntity", "startup", init)
