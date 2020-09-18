if !ui.enabled then return; end
local localplayer=LocalPlayer;
local grad=Material("gui/gradient_down");
local vguicreate=vgui.Create;
local setcol=surface.SetDrawColor;
local setmat=surface.SetMaterial;
local drawrect=surface.DrawRect;
local texrect=surface.DrawTexturedRect;
local drawtext=draw.SimpleText;
local frametime=RealFrameTime;
local clamp=math.Clamp;
local lerp=Lerp;
local col=Color;
local white=col(255,255,255,255);
local center=TEXT_ALIGN_CENTER;

local apnl={};

function apnl:Init()
    self:SetSize(280,35);
    self:Center();
    local shield=vguicreate("DImage",self);
    shield:SetPos(5,5);
    shield:SetSize(25,25);
    shield:SetImage("materials/hud/armor.png");
end

function apnl:Paint(w,h)
	-- This is the background of the bar, we are setting the gradient material to the background, and applying a black color. This can be changed with RW's color library
    setcol(0,0,0,240);
    setmat(grad);
    drawrect(0,0,w,h*3);
    -- This is the foreground of the bar, the foreground is used behind the actual colored bar to provide a background for the gradient.
    setcol(0,0,0,225);
    drawrect(82,10,190,17);
    -- LERP is utilized here to provide a smoother drawing when the bar increases and decreases. 
    local aw=190;
    local ah=17;
    local armor=localplayer():Armor();
    if !self.armor then self.armor=armor; end
    self.armor = lerp(frametime()*5,self.armor,armor);
    if self.armor<=0 then self.armor=0; end
    -- armor bar
    setcol(2,172,240,225);
    setmat(grad);
    texrect(82, 10,clamp(aw*(self.armor/100),0,aw),ah);
    -- armor numerical 
    drawtext(armor,"rw28",56,18,white,center,center);
end
ui.add("cl_armor",apnl,"cl_ddraggable");