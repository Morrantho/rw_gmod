local reg = vgui.Register;
local col = surface.SetDrawColor;
local rct = surface.DrawRect;
local get = cache.get;
local wht = cfg.colors[1];
local bg  = cfg.colors[22];
local bg2 = Color(bg.r*.7,bg.g*.7,bg.b*.7,200);
ui.durability = {};
ui.durability.pnl = ui.durability.pnl || nil;

local panel = {};

function panel:Init()
	local scrw,scrh = ScrW(),ScrH();
	local w,h = scrw/8,scrh/32;
	local xoff,yoff = 32,32;
	self:SetSize(w,h);
	self:SetPos(xoff,scrh-h-yoff);

	self.btn = vgui.Create("ui.dbutton",self);
	self.btn:Dock(FILL);
	self.btn:SetTextColor(wht);
	self.btn:SetText("");
	function self.btn:Paint(w,h) end
end
reg("ui.durability",panel,"ui.dpanel");

function ui.durability:on()
	if !IsValid(self.pnl) then
		self.pnl = vgui.Create("ui.durability");
	else
		if !self.pnl:IsVisible() then self.pnl:Show(); end
	end
end
function ui.durability:off()
	if !IsValid(self.pnl) then
		self.pnl = vgui.Create("ui.durability");
	end
	if self.pnl:IsVisible() then self.pnl:Hide(); end
end
function ui.durability.Think()
	local uid = ui.durability;
	local pnl = uid.pnl;
	local lp  = LocalPlayer();
	local sid = lp:SteamID();
	local wep = lp:GetActiveWeapon();
	if !IsValid(wep) then uid:off(); return; end
	local idx  = wep:get_data("idx");
	if !idx then uid:off(); return; end
	local item = get("inventories",sid,idx);
	local dur  = item.durability;
	if !dur then uid:off(); return; end
	local _item = get("craftable",item.name);
	local maxdur = _item.durability;
	uid:on();
	local fmt = "Durability: "..dur.."/"..maxdur;
	pnl.btn:SetText(fmt);
end
hook.Add("Think","ui.durability.Think",ui.durability.Think);