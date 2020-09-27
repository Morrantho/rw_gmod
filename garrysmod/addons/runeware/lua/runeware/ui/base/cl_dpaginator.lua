if !ui.enabled then return; end
local vguicreate=vgui.Create;
local push=table.insert;
local popf=table.remove;

local panel={};
panel.dbg=false;

function panel:Init()
	local scrw,scrh = ScrW(),ScrH();
	local pw,ph=scrw/2,scrh/2;
	local navh=scrh/32;
	local bodyh=ph-navh;
	self:Dock(FILL);

	self.paginator=vguicreate("cl_dpanel",self);
	self.paginator:Dock(TOP);
	self.paginator:SetTall(navh);
	self.paginator.Paint=nil;

	local left=vguicreate("cl_dbutton",self.paginator);
	left:Dock(LEFT);
	left:SetWide(navh);
	left:SetText("◀");
	left.DoClick=function(b)
		self.pageidx=self.pageidx-1;
		if self.pageidx==0 then self.pageidx=1; end
		self:mkpages();
	end
	local right=vguicreate("cl_dbutton",self.paginator);
	right:Dock(RIGHT);
	right:SetWide(navh);
	right:SetText("▶");
	right.DoClick=function(b)
		self.pageidx=self.pageidx+1;
		if self.pageidx>#self.pages then self.pageidx=#self.pages; end
		self:mkpages();
	end

	self.body=vguicreate("cl_dpanel",self);
	self.body:Dock(TOP);
	self.body:SetTall(bodyh);
	self.body.Paint=nil;

	self.btnsperpage=8; -- tabs / buttons per page
	self.btnw=(pw-(navh*2))/self.btnsperpage; -- the width of each button
	self.btncnt=1; -- resets each time a page is full.
	self.pagecnt=1; -- total number of pages.
	self.pageidx=1; -- current page index
	self.btns={}; -- button panel ptrs
	self.pages={}; -- page data for recreating buttons and pages.
	self.page=nil; -- current shown page
	if self.dbg then self:dodbg(); end
end

function panel:Paint(s,w,h) end

function panel:dodbg()
	self.btnsperpage=8;
	self.btnw=((ScrW()/2)-((ScrH()/32)*2))/self.btnsperpage;
	for i=1,16 do -- make 4 scrollable pages
		self:addpage("materials/hud/wanted.png","Panel "..i,"cl_dbutton");
	end
	self:mkpages();
end

function panel:mkpages()
	local pages=self.pages[self.pageidx];
	-- delete old buttons
	for i=1,#self.btns do
		if IsValid(self.btns[i]) then self.btns[i]:Remove(); end
		self.btns[i]=nil;
	end
	-- build new buttons
	for i=1,#pages do
		local btn=vguicreate("cl_dimagelabel",self.paginator);
		btn:Dock(LEFT);
		btn:SetWide(self.btnw+1);
		btn:setup(pages[i][1],pages[i][2],function()
			if IsValid(self.page) then self.page:Remove(); end -- delete old page reference / panel.
			self.page=vguicreate(pages[i][3],self.body); -- page panel class.
			self.page:Dock(FILL);
			for j=1,#self.btns do
				if self.btns[j].active then
					self.btns[j].active=false;
				end
			end
			btn.active=true;
		end);
		push(self.btns,btn);
	end
end

function panel:addpage(img,title,pnlcls)
	if !self.pages[self.pagecnt] then
		self.pages[self.pagecnt]={};
	end
	self.pages[self.pagecnt][self.btncnt]={img,title,pnlcls};
	self.btncnt=self.btncnt+1;
	if self.btncnt>self.btnsperpage then
		self.btncnt=1;
		self.pagecnt=self.pagecnt+1;
	end
end
ui.add("cl_dpaginator",panel,"cl_dpanel");