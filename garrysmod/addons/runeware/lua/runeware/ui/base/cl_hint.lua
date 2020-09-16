if !ui.enabled then return; end
local setcolor         = surface.SetDrawColor;
local getcolor         = color.get;
local drawrect         = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;
local scrw,scrh        = ScrW,ScrH;
local vguicreate       = vgui.Create;
local entbyindex       = ents.GetByIndex;

local panel = {};

function panel:Init()
	local sw,sh = scrw(),scrh();
	local w,h = sw/5,sh/7;
	local navh = self.nav:GetTall();
	self:SetSize(w,h);

	self.close.DoClick = function()
		if self.onclose then self.onclose(); end
		prompt.dequeue(self);	
	end

	self.body = vguicreate("cl_dpanel",self);
	self.body:Dock(TOP);
	self.body:SetTall(h-(navh*2));
	self.body.Paint=nil;

	self.text = vguicreate("DLabel",self.body);
	self.text:SetContentAlignment(5);
	self.text:SetFont("rw20");
	self.text:SetTextColor(color.get("whitest"));
	self.text:SetText("Suck my ass?");
	self.text:Dock(FILL);

	self.footer=vguicreate("cl_dpanel",self);
	self.footer:Dock(TOP);
	self.footer:SetTall(navh);

	self:Center();
end
ui.add("cl_hint",panel,"cl_dframe");