--gHUD, part of gUI--

--Begin Localization--
local lclply = LocalPlayer
local vguicreate = vgui.Create
local setcol = surface.SetDrawColor
local setmat = surface.SetMaterial
local rect = surface.DrawTexturedRect
local drawrect = surface.DrawRect
local vcreate = vgui.Create
local graddown = Material("gui/gradient_down")
local col = Color
local lerp = Lerp
local scrw,scrh = ScrW(),ScrH()
local white = col(255,255,255,255)
local frametime = RealFrameTime
local black = col(0,0,0,255)
local clampazzo = math.Clamp
local center = TEXT_ALIGN_CENTER
local panel = {}
--End Localization--

--Begin HUD Panel; ENSURE YOU SCALED THE BLOODY SHIT YOU TWAT--

function panel:Init()
--Health--
    local heart = vcreate("DImage", self)
    heart:SetImage("materials/hud/hp.png")
--Armor--
    local shield = vcreate("DImage", self)
    shield:SetImage("materials/hud/armor.png")
--Panel Size / Functions--
    self.heart = heart
    self.shield = shield
    self:SetSize(scrw*.170, scrh*.100)
    self:Center()
end
--Scaling based of resolution change--
function panel:OnSizeChanged(nw, nh)
--HP--
    local square = nh*.35
    self.heart:SetSize(square, square)
    self.heart:SetPos(nw*.05, nh*.10)
--Armor--
    self.shield:SetSize(square, square)
    self.shield:SetPos(nw*.05, nh*.5)
end
--End HUD Panel--
--Begin Rescaling OnScreenSizeChanged
function panel:OnScreenSizeChanged(ow, oh)
    scrw = ScrW()
    scrh = ScrH()
    self:SetSize(scrw*.170, scrh*.100)
    self:Center()
end
--End Rescaling OnScreenSizeChanged--
--Begin Painting the HUD; ENSURE YOU SCALED ALL ITEMS--
function panel:Paint(w,h)
--BG--
    setcol(0,0,0,240)
    setmat(graddown)
    rect(0,0,w,h*3)
--FG / HP--
    local hpw = w*.70
    local hph = h*.20
    local armw = hpw
    local armh = hph
    setcol(0,0,0,200)
    drawrect(w*.25, h*.20, hpw, hph)
--FG / ARMOR--
    setcol(0,0,0,200)
    drawrect(w*.25, h*.60, armw, armh)
--LERP--
    local lclply = lclply()
    local hp=lclply:Health()
    if !self.hp then self.hp=hp end
    self.hp = lerp(frametime()*5,self.hp,hp)
    if self.hp<=0 then self.hp=0 end

    local armor=lclply:Armor()
    if !self.armor then self.armor=armor end
    self.armor = lerp(frametime()*5,self.armor,armor)
    if self.armor<=0 then self.armor=0 end
--HP Bar--
    local maxhp = lclply:GetMaxHealth()
    setcol(0,217,61,225)
    drawrect(w*.25, h*.20, clampazzo(hpw*(self.hp/maxhp),0,hpw),hph)
--Armor Bar--
    local maxarmor = 100
    setcol(0,217,61,225)
    drawrect(w*.25, h*.60, clampazzo(armw*(self.armor/maxarmor),0,armw),armh)
end
--End Painting the HUD--
print("If you are seeing this, the HUD has established, or its file has loaded successfully.")
ui.add("cl_hud", panel, "cl_ddraggable")