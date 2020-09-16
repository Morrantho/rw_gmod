if !ui.enabled then return; end
local setcolor         = surface.SetDrawColor;
local getcolor         = color.get;
local drawrect         = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;

local panel = {};

function panel:Init()

end

function panel:Paint(w,h)
	setcolor(getcolor("blacker"));
	drawrect(0,0,w,h);
	setcolor(getcolor("blackest"));
	drawoutlinedrect(0,0,w,h);
end

function panel:GetContentSize()
	local canvas = self:GetCanvas()
	local w, h = canvas:GetSize() 

	for k, v in ipairs(canvas:GetChildren()) do
		local posx, posy = v:GetPos()
		local neww = posx + v:GetWide()
		local newh = posy + v:GetTall() 

		w = neww > w and neww or w
		h = newh > h and newh or h 
	end

	return w, h
end

function panel:IsScrollEnabled()
	return select(2, self:GetContentSize()) > self:GetTall()
end

ui.add("cl_dscrollpanel",panel,"DScrollPanel");