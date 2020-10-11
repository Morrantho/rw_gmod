local vguicreate=vgui.Create;
local keydown=input.IsKeyDown;
local panel={};

function panel:Init()
	local navh=self.nav:GetTall();
	self.body=vguicreate("cl_dpaginator",self);
	local h=self.body:GetTall();
	self.body:SetTall(h-navh);
	self:mkpages();
	self:MakePopup();
end

function panel:mkpages()
	self.body:addpage("materials/f4/jobs.png","Jobs","cl_jobs");
	self.body:addpage("materials/f4/shop.png","Shop","cl_dbutton");
	self.body:addpage("materials/f4/inventory.png","Inventory","cl_dbutton");
	self.body:addpage("materials/f4/crafting.png","Crafting","cl_dbutton");
	self.body:addpage("materials/f4/perks.png","Perks","cl_dbutton");
	self.body:addpage("materials/f4/laws.png","Laws","cl_laws");
	self.body:addpage("materials/f4/agendas.png","Agendas","cl_dbutton");
	self.body:addpage("materials/f4/settings.png","Settings","cl_dbutton");
	self.body:addpage("materials/f4/rules.png","Rules","cl_dbutton");
	self.body:addpage("materials/f4/donate.png","Donate","cl_dbutton");
	self.body:addpage("materials/f4/steam.png","Steam","cl_dbutton");
	self.body:mkpages();
end

function panel:Think()
	local prs=keydown(KEY_F4);
	if prs&&!self.down then self.down=true; end
	if !prs&&!self.up then self.up=true; end
	if self.down&&self.up&&prs then--pressed once, released once, then pressed again.
		self:Remove();
		self.down=false;
		self.up=false;
	end
end
ui.add("cl_f4",panel,"cl_dframe");