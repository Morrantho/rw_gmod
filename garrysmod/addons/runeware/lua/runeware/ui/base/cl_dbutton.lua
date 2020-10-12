if !ui.enabled then return; end
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local scale=font.scale;

local panel = {};

function panel:Init()
	self:SetText("");
	self:SetFont("rw18");
	self:SetTextColor(getcol("whitest"));
	self:Center();
	self:SetTall(ScrH()/32);
	self.active=false;
end

function panel:Paint(w,h)
	if self:IsHovered() then
		setcol(getcol("black"));
		self:SetTextColor(getcol("green"));
	else
		setcol(getcol("blackerer"));
		self:SetTextColor(getcol("whitest"));
	end
	if self.active then
		setcol(getcol("green"));
	end
	if self.active&&self:IsHovered() then
		self:SetTextColor(getcol("whitest"));
	end
	rect(0,0,w,h);
	setcol(getcol("blacker"));
	olrect(0,0,w,h);
	--self:SetFont(scale("rw",h));
end
ui.add("cl_dbutton",panel,"DButton");