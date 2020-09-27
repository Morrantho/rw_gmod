local vguicreate=vgui.Create;
local panel={};

function panel:Init()
	self.title:SetFont("rwtitle32");
	self.title:SetText("R");
	local navh=self.nav:GetTall();
	self.body=vguicreate("cl_dpaginator",self);
	local h=self.body:GetTall();
	self.body:SetTall(h-navh);
	self:mkpages();
end

function panel:mkpages()
	self.body:addpage("materials/f4/shop.png","Shop","cl_dbutton");
	self.body:addpage("materials/f4/jobs.png","Jobs","cl_dbutton");
	self.body:addpage("materials/f4/inventory.png","Inventory","cl_dbutton");
	self.body:addpage("materials/f4/perks.png","Perks","cl_dbutton");
	self.body:addpage("materials/f4/crafting.png","Crafting","cl_dbutton");
	self.body:addpage("materials/f4/settings.png","Settings","cl_dbutton");
	self.body:addpage("materials/f4/rules.png","Rules","cl_dbutton");
	self.body:mkpages();
end
ui.add("cl_f4",panel,"cl_dframe");