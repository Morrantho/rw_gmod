local reg = vgui.Register;
local col = surface.SetDrawColor;
local rct = surface.DrawRect;
local get = cache.get;
local wht = cfg.colors[1];
local bg  = cfg.colors[22];
local bg2 = Color(bg.r*.7,bg.g*.7,bg.b*.7,200);
ui.ammo = {};
ui.ammo.pnl = ui.ammo.pnl || nil;

local panel = {};

function panel:Init()
	local scrw,scrh = ScrW(),ScrH();
	local w,h = scrw/8,scrh/32;
	local xoff,yoff = 32,32;
	self:SetSize(w,h);
	self:SetPos(scrw-w-xoff,scrh-h-yoff);

	self.btn = vgui.Create("ui.dbutton",self);
	self.btn:Dock(FILL);
	self.btn:SetTextColor(wht);
	self.btn:SetText("");
	function self.btn:Paint(w,h) end
end
reg("ui.ammo",panel,"ui.dpanel");

function ui.ammo:on()
	if !IsValid(self.pnl) then
		self.pnl = vgui.Create("ui.ammo");
	else
		if !self.pnl:IsVisible() then self.pnl:Show(); end
	end
end
function ui.ammo:off()
	if !IsValid(self.pnl) then
		self.pnl = vgui.Create("ui.ammo");
	end
	if self.pnl:IsVisible() then self.pnl:Hide(); end
end
function ui.ammo.Think()
	local uid = ui.ammo;
	local pnl = uid.pnl;
	local lp  = LocalPlayer();
	local sid = lp:SteamID();
	local wep = lp:GetActiveWeapon();
	if !IsValid(wep) then uid:off(); return; end
	if !wep.Ammo1 then uid:off(); return; end
	if !wep.Clip1 then uid:off(); return; end
	local clip1 = wep:Clip1();
	local ammo1 = wep:Ammo1();
	if clip1 == -1 then uid:off(); return; end
	if ammo1 == -1 then uid:off(); return; end
	if ammo1 == 0 && clip1 == 0 then uid:off(); return; end
	local fmt = clip1.."/"..ammo1;
	uid:on();
	if IsValid(pnl) then 
		pnl.btn:SetText(fmt);
	end
end
hook.Add("Think","ui.ammo.Think",ui.ammo.Think);