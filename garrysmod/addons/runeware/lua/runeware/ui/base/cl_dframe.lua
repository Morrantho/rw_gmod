if !ui.enabled then return; end
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local scale=font.scale;

local panel={};

function panel:Init()
	local scrw,scrh=ScrW(),ScrH();
	local w,h=scrw/2,scrh/2;
	self:SetSize(w,h);
	self:Center();
	-- self:MakePopup();
	self:ShowCloseButton(false);
	self:SetTitle("");
	self:DockPadding(0,0,0,0);
	self:DockMargin(0,0,0,0);

	self.nav=vgui.Create("cl_dpanel",self);
	self.nav:Dock(TOP);
	self.nav:SetTall(scrh/32);
	self.nav.Paint=function(s,w,h)
		surface.SetDrawColor(color.get("green"));
		surface.DrawRect(0,0,w,h);
	end

	self.title=vgui.Create("cl_dbutton",self.nav);
	self.title:Dock(LEFT);
	self.title:SetText("Runeware");
	self.title.Paint=function(s,w,h)
		s:SetFont(scale("rw",h));
	end

	self.close=vgui.Create("cl_dbutton",self.nav);
	self.close:Dock(RIGHT);
	self.close:SetWide(self.nav:GetTall());
	self.close:SetText("x");
	self.close.Paint=function(s,w,h)
		if s:IsHovered() then
			s:SetTextColor(color.get("green"));
		else
			s:SetTextColor(color.get("whitest"));
		end
		s:SetFont(scale("rw",h));
	end
	self.close.DoClick=function()
		self:Close();
	end
end

function panel:Think()
	self.title:SizeToContentsX(16);
end

function panel:Paint(w,h)
	setcol(getcol("blackest"));
	rect(0,0,w,h);
	setcol(getcol("blacker"));
	olrect(0,0,w,h);
end
ui.add("cl_dframe",panel,"DFrame");