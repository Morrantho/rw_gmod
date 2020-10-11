if !ui.enabled then return; end
local setcolor         = surface.SetDrawColor;
local getcolor         = color.get;
local drawrect         = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;
local scrw,scrh        = ScrW,ScrH;
local vguicreate       = vgui.Create;
local entbyindex       = ents.GetByIndex;
local scale=font.scale;
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

	self.body=vguicreate("cl_dpanel",self);
	self.body:Dock(TOP);
	self.body:SetTall(h-navh);
	self.body.Paint=nil;

	self.text=vguicreate("cl_dlabel",self.body);
	self.text:Dock(FILL);
	self:Center();
end
ui.add("cl_hint",panel,"cl_dframe");