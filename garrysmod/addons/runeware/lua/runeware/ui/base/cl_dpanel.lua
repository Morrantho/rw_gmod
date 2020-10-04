if !ui.enabled then return; end
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local scrw,scrh        = ScrW,ScrH;

local panel = {};

function panel:Init()
	self:SetSize(scrw()/2,scrh()/2);
	self:Center();
end

function panel:Paint(w,h)
	setcol(getcol("blackest"));
	rect(0,0,w,h);
	setcol(getcol("blacker"));
	olrect(0,0,w,h);
end
ui.add("cl_dpanel",panel,"DPanel");