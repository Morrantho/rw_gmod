local col   = surface.SetDrawColor;
local rct   = surface.DrawRect;
local orct  = surface.DrawOutlinedRect;
local get   = cache.get;

local wht   = cfg.colors[1];
local bg    = cfg.colors[22];
local bg2   = Color(bg.r*0.5,bg.g*0.5,bg.b*0.5,200)

local panel = {};

function panel:Init()
	local pw,ph  = self:GetParent():GetSize();
	local this   = self;
	self.col     = wht;
	self:Dock(LEFT);
	self:DockMargin(0,0,0,0);
	self:DockPadding(0,0,0,0);

	self.img = vgui.Create("DImage", self);
	self.img:Dock(LEFT);
	self.img:SetSize(ph,ph);
	self.img:SetImage("vgui/avatar_default");
	self.img:DockMargin(0,0,0,0);
	self.img:DockPadding(0,0,0,0);

	self.txt = vgui.Create("DButton",self);
	self.txt:Dock(LEFT);
	self.txt:DockMargin(8,0,8,0);
	self.txt:DockPadding(0,0,0,0);
	self.txt:SetFont("rw24");
	self.txt:SetText("");
	self.txt:SetTextColor(wht);
	function self.txt:Paint(w,h) end
end

function panel:SetText(txt)
	self.txt:SetText(txt);
	self.txt:SizeToContentsX();
	local w = self.img:GetWide() + self.txt:GetContentSize();
	local imgL, imgT, imgR, imgB = self.img:GetDockMargin();
	local txtL, txtT, txtR, txtB = self.txt:GetDockMargin();
	w = w+imgL+imgR+txtL+txtR;
	self:SetWide(w);
end

function panel:SetImage(img)
	self.img:SetImage(img);
end

function panel:SetColor(c)
	self.col = c;
end

function panel:Paint(w,h)
	local iw,ih = self.img:GetSize();
	if !self.col then self.col = wht; end
	local c = Color(self.col.r,self.col.g,self.col.b,10);
	local d = Color(self.col.r,self.col.g,self.col.b,70);
	col(d);
	rct(0,0,iw,ih);

	col(c);
	rct(iw,0,w-iw,h);

	col(d);
	orct(iw,0,w-iw,h);
end

function panel:Think()
	local p    = LocalPlayer();
	local key  = self.key;
	local data = nil;
	local func = p[key];
	if func then
		data = func(p);
	else
		data = p:get_data(key);
		if !data then 
			data = get("global","data",key);
		end
	end
	if data then
		local res = self.func(data);
		if res && res ~= 0 then
			self:SetText(res);
		else
			self:SetWide(0);
		end
	else
		self:SetWide(0);
	end
end
vgui.Register("ui.huditem", panel, "DPanel")