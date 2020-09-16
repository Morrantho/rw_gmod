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

	self.body = vguicreate("cl_dscrollpanel",self);
	self.body:Dock(TOP);
	self.body:SetTall(h-navh);
	self.body.Paint = nil;
	self.body:Dock(FILL);

	self.close.DoClick = function()
		prompt.dequeue(self);
	end

	self:Center();
end

function panel:add(txt,doclick)
	local option = vguicreate("cl_dbutton",self.body);
	option:SetText(txt);
	option:Dock(TOP);
	option.DoClick = doclick;
	return option;
end
ui.add("cl_form",panel,"cl_dframe");