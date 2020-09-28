if !ui.enabled then return; end
local vguicreate=vgui.Create;
local setcol=surface.SetDrawColor;
local setmat=surface.SetMaterial;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local texrect=surface.DrawTexturedRect;

local panel={};
panel.dbg=true;

function panel:Init()
	self:SetText("");
	self:DockMargin(0,0,0,0);
	self:DockPadding(0,0,0,0);
	local pw,ph=self:GetParent():GetSize();

	self.pnl=vguicreate("DPanel",self);
	self.pnl:SetSize(ph,ph);
	self.pnl:Dock(LEFT);
	self.pnl.Paint=nil;

	self.img=vguicreate("DImage",self.pnl);
	self.img:Dock(FILL);
	self.img:SetImageColor(getcol("whitest"));
	self.img:DockMargin(4,4,4,4);

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
	local imgw=self.pnl:GetWide();
	if self:IsHovered() then
		setcol(getcol("black"));
	else
		setcol(getcol("blackerer"));
	end
	if self.active then
		setcol(getcol("black"));
		self.lbl:SetTextColor(getcol("green"));
	else
		self.lbl:SetTextColor(getcol("whitest"));
	end
	rect(0,0,w,h);
	setcol(getcol("black"));
	olrect(w-1,0,1,h);
end
ui.add("cl_dimagelabel",panel,"cl_dbutton");