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
local scrw,scrh = ScrW(),ScrH();
local col=Color;
local white=col(255,255,255,255);
local center=TEXT_ALIGN_CENTER;

local panel={};

function panel:Init()
    self:SetSize(scrw*.145,scrh*.034);
    self:Center();
    local heart=vguicreate("DImage",self);
    heart:SetPos(5,5);
    heart:SetSize(25,25);
    heart:SetImage("materials/hud/health.png");
end

function panel:Paint(w,h)
	-- This is the background of the bar, we are setting the gradient material to the background, and applying a black color. This can be changed with RW's color library
    setcol(0,0,0,240);
    setmat(grad);
    drawrect(0,0,w,h*3);
    -- This is the foreground of the bar, the foreground is used behind the actual colored bar to provide a background for the gradient.
    setcol(0,0,0,225);
    drawrect(82,10,190,17);
    -- LERP is utilized here to provide a smoother drawing when the bar increases and decreases. 
    local hpw=190;
    local hph=17;
    local hp=localplayer():Health();
    if !self.hp then self.hp=hp; end
    self.hp = lerp(frametime()*5,self.hp,hp);
    if self.hp<=0 then self.hp=0; end
    -- The actual bar for the client, this will be used for the HP bar.
    local max=localplayer():GetMaxHealth();
    setcol(0,217,61,225);
    setmat(grad);
    texrect(82, 10,clamp(hpw*(self.hp/max),0,hpw),hph);
    -- Numerical HP values in case of overhealing.
    drawtext(hp,"rw28",56,18,white,center,center);
end
ui.add("cl_hp",panel,"cl_ddraggable");