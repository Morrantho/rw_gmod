if !ui.enabled then return; end
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local scale=font.scale;
local vguicreate=vgui.Create;

local panel={};
panel.dbg=true;

function panel:Init()
	self:Dock(FILL);
	self:SetFont("rw18");
	self:DockMargin(8,8,8,8);
	self:SetPaintBackground(false);
	self:SetTextColor(getcol("whitest"));
	self:SetCursorColor(getcol("whitest"));
	if self.dbg then self:dodbg(); else self.Paint=nil; end
end

function panel:dodbg()
	self:SetText("Mary had a little lamb. Little lamb. Little lamb.");
end
ui.add("cl_dtextentry",panel,"DTextEntry");