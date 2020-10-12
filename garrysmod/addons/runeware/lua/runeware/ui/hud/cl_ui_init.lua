local function init()
    local scrw = ScrW()
    local scrh = ScrH()

   -- hud.health = vgui.Create("cl_hp")
   -- hud.health:SetPos(scrw * .02, scrh * .65)
   -- hud.armor = vgui.Create("cl_armor")
   -- hud.armor:SetPos(scrw * .02, scrh * .69)
  --  hud.beta = vgui.Create("cl_beta")
    
end

if hud then 
    for k, v in pairs(hud) do 
        v:Remove()
    end
    init()
end

hud = hud or {} 

hook.Add("InitPostEntity", "startup", init)
