local vguicreate=vgui.Create;
local get=cache.get;
local entbyidx=ents.GetByIndex;
local panel={};
local scale=font.scale;
local netstart=net.Start;
local netsend=net.SendToServer;
local writestr=net.WriteString;
local writeuint=net.WriteUInt;

function panel:onedit()
	self.edit:SetText("Submit");
	self.laws=self.scroll:Add("cl_dtextentry");
	self.laws:SetMultiline(true);
end

function panel:ondisplay(isinit)
	if !isinit then self:send(); end
	self.edit:SetText("Edit");
	self.laws=self.scroll:Add("cl_dlabel");
	self.laws.Paint=nil;
end

function panel:format()
	self.laws:Dock(FILL);
	self.laws:SetTall(self.scrollh);
	self.laws:SetContentAlignment(7);
	self.laws:DockMargin(8,8,8,0);
	self.laws:SetText(get(entbyidx(0),"laws")||gov.defaultlaws);
	self.laws:SetFont(scale("rw",self.scrollh/13.5));
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
	local h=self:GetTall();
	self.scrollh=(h-(ScrH()/32)*3)+3;

	self.scroll=vguicreate("cl_dscrollpanel",self);
	self.scroll:Dock(TOP);
	self.scroll:SetTall(self.scrollh);

	self.edit=vguicreate("cl_dbutton",self);
	self.edit:SetText("Edit");
	self.edit:Dock(TOP);
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