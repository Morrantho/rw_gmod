if !ui.enabled then return; end
local vguicreate=vgui.Create;
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;

local panel={};
panel.dbg=true;

function panel:Init()
	self:SetText("");
	self:DockMargin(0,0,0,0);
	self:DockPadding(0,0,0,0);
	local pw,ph=self:GetParent():GetSize();
	self.img=vguicreate("DImage",self);
	self.img:SetSize(ph,ph);
	self.img:SetImageColor(getcol("whitest"));
	self.img:Dock(LEFT);

	self.lbl=vguicreate("cl_dlabel",self);
	self.lbl:Dock(FILL);
	self.lbl:SetContentAlignment(5);
end

function panel:setup(img,txt,func)
	self.img:SetImage(img);
	self.lbl:SetText(txt);
	self.DoClick=func;
end

function panel:Paint(w,h)
	local imgw=self.img:GetWide();
	if self:IsHovered() then
		setcol(getcol("black"));
		self.lbl:SetTextColor(getcol("green"));
		self.img:SetImageColor(getcol("green"));
		rect(0,0,w,h);

		setcol(getcol("green"));
		olrect(0,-1,imgw,h+2);
		olrect(w-1,0,1,h);
	else
		setcol(getcol("blackerer"));
		self.lbl:SetTextColor(getcol("whitest"));
		self.img:SetImageColor(getcol("whitest"));
		rect(0,0,w,h);

		setcol(getcol("black"));
		olrect(w-1,0,1,h);
		olrect(imgw,0,1,h);
		olrect(0,h-1,w,1);
	end
	if self.active then
		setcol(getcol("green"));
		rect(0,0,w,h);
		
		setcol(getcol("whitest"));
		olrect(0,-1,imgw,h+2);
		olrect(w-1,0,1,h);
	end
	if self.active&&self:IsHovered() then
		self.lbl:SetTextColor(getcol("whitest"));
		self.img:SetImageColor(getcol("whitest"));
		setcol(getcol("green"));
		rect(0,0,w,h);

		setcol(getcol("whitest"));
		olrect(0,-1,imgw,h+2);
		olrect(w-1,0,1,h);
	end
end
ui.add("cl_dimagelabel",panel,"cl_dbutton");