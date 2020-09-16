if !ui.enabled then return; end
local setcolor         = surface.SetDrawColor;
local getcolor         = color.get;
local drawrect         = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;
local scrw,scrh        = ScrW,ScrH;

local panel = {};

function panel:Init()
	self:SetSize(scrw()/2,scrh()/2);
	self:Center();
end

function panel:Paint(w,h)
	setcolor(getcolor("blacker"));
	drawrect(0,0,w,h);
	setcolor(getcolor("blackest"));
	drawoutlinedrect(0,0,w,h);
end
ui.add("cl_dpanel",panel,"DPanel");