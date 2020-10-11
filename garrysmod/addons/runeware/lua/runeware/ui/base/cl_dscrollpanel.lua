if !ui.enabled then return; end
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local vguicreate=vgui.Create;

local panel={};
panel.dbg=false;
-- Intended to be parented to another panel.
function panel:Init()
	self:Dock(FILL);
	if self.dbg then self:dodbg(); end
	self.VBar:SetWide(2);
	self.VBar.Paint=function(s,w,h) end--let these have the same bg color.
	self.VBar:SetHideButtons(true);--noone cares about these.
	self.VBar.btnGrip.Paint=function(s,w,h)
		if s:IsHovered() then s:SetCursor("hand"); end
		setcol(getcol("green"));
		rect(0,0,w,h);
	end
end

function panel:dodbg()
	--dont give these a paint unless debugging.
	self.Paint=function(s,w,h)
		setcol(getcol("blackest"));
		rect(0,0,w,h);
		setcol(getcol("blacker"));
		olrect(0,0,w,h);
	end
	self:Dock(NODOCK);
	self:SetSize(ScrW()/2,ScrH()/2);
	self:Center();
	for i=1,64 do
		local btn=vguicreate("cl_dbutton",self);
		btn:Dock(TOP);
		btn:SetText("Button "..i);
	end
end

function panel:GetContentSize()
	local canvas=self:GetCanvas()
	local w,h=canvas:GetSize() 
	for k,v in ipairs(canvas:GetChildren()) do
		local posx,posy=v:GetPos();
		local neww=posx+v:GetWide();
		local newh=posy+v:GetTall();
		w=neww>w&&neww||w
		h=newh>h&&newh||h
	end
	return w,h
end

function panel:IsScrollEnabled()
	return select(2, self:GetContentSize()) > self:GetTall()
end
ui.add("cl_dscrollpanel",panel,"DScrollPanel");