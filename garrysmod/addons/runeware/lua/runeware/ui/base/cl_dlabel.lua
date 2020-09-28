if !ui.enabled then return; end
local setcolor = surface.SetDrawColor;
local getcolor = color.get;
local drawrect = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;

local panel = {};

function panel:Init()
	self:SetText("");
	self:SetFont("rw20");
	self:SetTextColor(getcolor("whitest"));
	self:SetContentAlignment(5);
end
ui.add("cl_dlabel",panel,"DLabel");