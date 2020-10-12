ui.hud     = {};
if ui.hud.pnl && ui.hud.pnl:IsValid() then
	print("REMOVING HUD");
	ui.hud.pnl:Remove();
end
local ceil = math.ceil;
local mat  = surface.SetMaterial;
local col  = surface.SetDrawColor;
local rct  = surface.DrawRect;
local orct  = surface.DrawOutlinedRect;
local trt  = surface.DrawTexturedRect;
local fnt  = surface.SetFont;
local bg   = cfg.colors[22];
local bg2  = Color(bg.r*.7,bg.g*.7,bg.b*.7,200)
local wht  = cfg.colors[1];
local blk  = cfg.colors[2];
local red  = cfg.colors[3];
local grn  = cfg.colors[6];
local grn2 = cfg.colors[7];
local grn3 = cfg.colors[8];
local blu  = cfg.colors[9];
local blu2 = cfg.colors[10];
local blu3 = cfg.colors[11];
local yel  = cfg.colors[18];
local org  = cfg.colors[12];
local prp  = cfg.colors[16];
local prp3 = cfg.colors[17];
local grd  = cfg.materials[2];

local function ntocommas(n)
	n = n.."";
	if #n < 4 then return n; end
	local s = "";
	local j = 0;
	for i=#n,1,-1 do
		if j == 3 then
			s = s..","..n[i];
			j = 0;
		else
			s = s..n[i];
			j = j+1;
		end
	end
	return s:reverse();
end

function ui.hud:Init()
	local w,h = ScrW(),ScrH();
	local this = self;
	self:SetSize(w,h/32);
	self:SetPos(0,0);
	self:add(LEFT,"materials/hud/health.png",red,"Health",function(v)
		if v && v <= 0 then return 0; end
		return v;
	end)
	self:add(LEFT,"materials/hud/armor.png",blu,"Armor",function(v)
		if v && v > 0 then return ceil(v); end
	end)
	self:add(LEFT,"materials/hud/hunger.png",grn,"hunger",function(v)
		if v && v > 0 then return v; end
		return "STARVING";
	end)
	self:add(LEFT,"materials/hud/salary.png",grn,"runes",function(v)
		return string.Comma(v);
	end)
	self:add(LEFT,"materials/hud/nlr.png",prp,"nlr",function(v)
		if v && v > 0 then return v; end
	end)
	self:add(LEFT,"materials/hud/grace.png",org,"grace",function(v)
		if tonumber(v) && v > 0 then return v; end
	end)
	self:add(LEFT,"materials/hud/wanted.png",wht,"wanted",function(v)
		if v && v > 0 then return v; end
	end)
	self:add(LEFT,"materials/hud/warranted.png",wht,"warranted",function(v)
		if v && v > 0 then return v; end
	end)
	self:add(LEFT,"materials/hud/arrested.png",wht,"arrested",function(v)
		if v && v > 0 then return v; end
	end)		
	self:add(LEFT,"materials/hud/lockdown.png",wht,"lockdown",function(v)
		if v && v == 1 then return "LOCKDOWN"; end
	end)
	
	local laws = self:add(RIGHT,"materials/hud/grace.png",grn,nil,function(v)
		return "Laws";
	end);
	function laws.txt:DoClick() LocalPlayer():ConCommand("laws"); end
	
	local perks = self:add(RIGHT,"materials/hud/sex.png",grn,nil,function(v)
		return "Perks";
	end);
	function perks.txt:DoClick() LocalPlayer():ConCommand("perks"); end

	local crafting = self:add(RIGHT,"materials/hud/job.png",grn,nil,function(v)
		return "Crafting";
	end);
	function crafting.txt:DoClick() LocalPlayer():ConCommand("crafting"); end

	self.drop = vgui.Create("DPanel",self);
	self.drop:Dock(FILL);
	self.drop:SetVisible(false);
	function self.drop:Paint() end
	function self.drop:SetText(from,msg)
		local h = self:GetTall();
		this.from:SetTall(h/3);
		this.from:SetText(from..":");
		this.msg:SetTall(h-(h/3));
		this.msg:SetText(msg);
	end
	self.from = vgui.Create("DLabel",self.drop);
	self.from:Dock(TOP);
	self.from:SetContentAlignment(5);
	self.from:SetFont("rw24");
	self.from:SetTextColor(wht);
	self.from:SetText("");
	self.msg = vgui.Create("DLabel",self.drop);
	self.msg:Dock(TOP);
	self.msg:SetContentAlignment(5);
	self.msg:SetFont("rw48");
	self.msg:SetTextColor(red);
	self.msg:SetText("");
	self.dropped = false;
end
function ui.hud:add(dock,img,col,key,func)
	local pnl = vgui.Create("ui.huditem",self);
	pnl:Dock(dock);
	pnl:SetImage(img);
	pnl:SetColor(col);
	pnl.key = key;
	pnl.func = func;
	return pnl;
end
function ui.hud:Paint(w,h)
	col(bg2);
	rct(0,0,w,h);
	col(grn);
	rct(0,h-1,w,1);
end
function ui.hud:tell(from,msg)
	if self.dropped then return; end
	self.dropped = true	;
	local kids  = self:GetChildren();
	local old_h = self:GetTall();
	local new_h = ScrH()/4;
	local this  = self;
	for i=1,#kids do kids[i]:SetVisible(false); end
	this.drop:SetVisible(true);
	self:SizeTo(-1,new_h,.25,0,-1,function()
		local laws = ui.laws.pnl:IsVisible();
		if laws then ui.laws.pnl:Hide(); end
		this.drop:SetText(from,msg);
		this:SizeTo(-1,old_h,.25,5,-1,function()
			for i=1,#kids do kids[i]:SetVisible(true); end
			this.drop:SetText("","");
			this.drop:SetVisible(false);
			this.dropped = false;
			if laws then ui.laws.pnl:Show(); end
		end)
	end)
end
function ui.hud:toggle()
	if !self.pnl then
		self.pnl = vgui.Create("ui.hud");
	else
		self.pnl:Toggle();
	end
end
vgui.Register("ui.hud",ui.hud,"ui.dpanel")