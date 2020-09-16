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
	self:Center();
	self:SetTall(ScrH()/32);
end

function panel:Paint(w,h)
	if self:IsHovered() then
		setcolor(getcolor("white"));
	else
		setcolor(getcolor("blackest"));
	end
	drawrect(0,0,w,h);
	setcolor(getcolor("blackest"));
	drawoutlinedrect(0,0,w,h);
end
ui.add("cl_dbutton",panel,"DButton");