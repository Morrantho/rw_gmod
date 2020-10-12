local vguicreate=vgui.Create;
local get=cache.get;
local entbyidx=ents.GetByIndex;
local panel={};
local scale=font.scale;
local netstart=net.Start;
local netsend=net.SendToServer;
local writestr=net.WriteString;
local writeuint=net.WriteUInt;
local setcol=surface.SetDrawColor;
local getcol=color.get;
local olrect=surface.DrawOutlinedRect;
local rect=surface.DrawRect;

function panel:onedit()
	self.edit:SetText("Submit");
	self.laws=self.scroll:Add("cl_dtextentry");
	self.laws:SetMultiline(true);
	self.laws:DockMargin(0,0,0,0);
	self.laws:DockPadding(0,0,0,0);
	--self.laws:
end

function panel:ondisplay(isinit)
	if !isinit then self:send(); end
	self.edit:SetText("Edit");
	self.laws=self.scroll:Add("cl_dlabel");
end

function panel:format()
	self.laws:Dock(TOP);
	self.laws:SetTall(self.scroll:GetTall());
	self.laws:SetContentAlignment(7);
	self.laws:SetText(get(entbyidx(0),"laws")||gov.defaultlaws);
	--self.laws.Paint=function(s,w,h)
	--	setcol(getcol("blackerer"));
	--	rect(0,0,w,h);
	--	setcol(getcol("blacker"));
	--	olrect(0,0,w,h);
	--end
end

function panel:send()
	local laws=self.laws:GetText();
	if laws==get(entbyidx(0),"laws") then return; end
	if !LocalPlayer():ismayor() then
		err("Only the mayor can set laws");
		return;
	end
	if #laws<1||#laws>2048 then
		err("Laws must be between 1-2048 characters in length.");
		return;
	end
	netstart("gov.onsetlaws");
	writeuint(LocalPlayer():UserID(),7);
	writestr(laws);
	netsend();
end

function panel:Init()
	self:Dock(FILL);
	self:DockMargin(8,8,8,8);

	local h=self:GetTall();
	self.scroll=vguicreate("cl_dscrollpanel",self);
	self.scroll:Dock(TOP);
	self.scroll:SetTall(h-ScrH()/32-4);

	self.edit=vguicreate("cl_dbutton",self);
	self.edit:SetText("Edit");
	self.edit:Dock(TOP);
	self.edit:DockMargin(0,1,0,0);
	self.edit.DoClick=function(s)
		if IsValid(self.laws) then self.laws:Remove(); end
		if s:GetText()=="Edit" then
			self:onedit();
		else
			self:ondisplay(false);
		end
		self:format();
	end

	self:ondisplay(true);
	self:format();
end
function panel:Paint() end
ui.add("cl_laws",panel,"cl_dpanel");