local vguicreate=vgui.Create;
local scale=font.scale;
local push=table.insert;
local setcol=surface.SetDrawColor;
local getcol=color.get;
local rect=surface.DrawRect;
local olrect=surface.DrawOutlinedRect;
local jobplys=job.getplayers;
local rand=math.random;
local min,max,abs=math.min,math.max,math.abs;
local floor=math.floor;
local vec=Vector;

local panel={};

function panel:mkcategory(title)
	local cat=self.left:Add("cl_dbutton");
	cat:Dock(TOP);
	cat:SetText(title:totitle());
	cat:DockMargin(0,1,0,0);
	cat.Paint=function(s,w,h)
		setcol(getcol("blacker"));
		rect(0,0,w,h);
		setcol(getcol("black"));
		olrect(0,0,w,h);
		s:SetFont(scale("rw",h));
	end
end

function panel:setupmodel(isinit)
	if isinit then
		self.mdlidx=rand(1,#self.job.models);
		self.mdl=self.job.models[self.mdlidx];
	end
	self.rmodel:SetModel(self.mdl);
	local ent=self.rmodel.Entity;
	local pos=ent:GetBonePosition(0);
	self.rmodel:SetLookAt(pos+vec(0,0,-3));
	self.rmodel:SetCamPos(pos+vec(70,0,0));
	ent:SetEyeTarget(pos-Vector(-15, 0, 0));
end

function panel:pagemodel(dir)
	if !self.mdlidx||!self.mdl||!self.job then return; end
	self.mdlidx=self.mdlidx+dir;--+ or - floor(pickerw/btnh*2)
	if self.mdlidx<1 then self.mdlidx=1; end
	if self.mdlidx>#self.job.models then self.mdlidx=#self.job.models; end
	self:mkpickerbtns();
end

function panel:mkjob(_job)
	local btn=self.left:Add("cl_dbutton");
	btn:Dock(TOP);
	btn:SetTall(btn:GetTall()*2);
	btn:DockMargin(0,1,0,0);
	btn.Paint=function(s,w,h)
		if s:IsHovered() then
			setcol(getcol("black"));
		else
			setcol(getcol("blackerer"));
		end
		rect(0,0,w,h);
		setcol(getcol("blacker"));
		olrect(0,0,w,h);
		setcol(_job.color);
		if s.active then
			rect(1,0,w-2,1);
			rect(1,h-1,w-2,1);
		end
		s:SetFont(scale("rw",h));
	end
	btn.DoClick=function(s)
		for a,b in pairs(s:GetParent():GetChildren()) do
			if b.active then b.active=false; end
		end
		s.active=true;
		self.job=_job;
		self.rtitle:SetText(_job.name:totitle());
		self:setupmodel(true);
		self.mdlidx=1;
		self:mkpickerbtns();
		self.rdesc:SetText(_job.description);
		self.rdesc:SizeToContentsY(ScrH()/32);
	end
	local leftw=self.left:GetWide();

	local name=vguicreate("cl_dlabel",btn);
	name:Dock(LEFT);
	name:SetWide(leftw/2);
	name:SetText(_job.name:totitle());
	name:SetContentAlignment(4);
	name:DockMargin(8,0,0,0);
	name.Paint=function(s,w,h)
		s:SetFont(scale("rw",h/2));
	end

	local cnt=vguicreate("cl_dlabel",btn);
	cnt:Dock(LEFT);
	cnt:SetWide(leftw/2);
	cnt:SetContentAlignment(5);
	cnt.Paint=function(s,w,h)
		s:SetFont(scale("rw",h/2));
	end
	cnt.Think=function(s)
		if _job.limit==0 then
			s:SetText(#jobplys(_job.name).."/∞");
		else
			s:SetText(#jobplys(_job.name).."/".._job.limit);
		end
	end
end

function panel:mkleft()
	local teams={};
	for i=1,#job do
		if !teams[job[i].team] then teams[job[i].team]={}; end
		push(teams[job[i].team],job[i]);
	end
	for a,b in pairs(teams) do
		self:mkcategory(a);
		for i=1,#b do
			self:mkjob(b[i]);
		end
	end
end

function panel:mkpickerbtns()
	local pickerw=self.rpicker:GetWide();
	local btnw=self.rtitle:GetTall()*2;
	local nbtns=floor(pickerw/btnw);
	local kids=self.rpicker:GetChildren();
	for i=1,#kids do kids[i]:Remove(); end

	self.rpickerl=vguicreate("cl_dbutton",self.rpicker);
	self.rpickerl:Dock(LEFT);
	self.rpickerl:DockMargin(0,0,0,0);
	self.rpickerl:SetWide(btnw);
	self.rpickerl:SetText("◀");
	self.rpickerl.DoClick=function()
		self:pagemodel(-floor(pickerw/btnw));
	end

	self.rpickerr=vguicreate("cl_dbutton",self.rpicker);
	self.rpickerr:Dock(RIGHT);
	self.rpickerr:DockMargin(0,0,0,0);
	self.rpickerr:SetWide(btnw);
	self.rpickerr:SetText("▶");
	self.rpickerr.DoClick=function()
		self:pagemodel(floor(pickerw/btnw));
	end

	local mdls=self.job.models;
	for i=self.mdlidx,nbtns+self.mdlidx-3 do
		if !mdls[i] then continue; end
		local pnl=vguicreate("DModelPanel",self.rpicker);
		pnl:Dock(LEFT);
		pnl:DockMargin(1,0,0,0);
		pnl:SetWide(btnw);
		pnl:SetModel(mdls[i]);
		local head=pnl.Entity:LookupBone("ValveBiped.Bip01_Head1");
		local pos=pnl.Entity:GetBonePosition(head);
		pnl:SetLookAt(pos+vec(10,0,0));
		pnl:SetCamPos(pos+vec(15,0,0));
		pnl.Entity:SetEyeTarget(pos+vec(15,0,0));
		pnl.LayoutEntity=function() return; end
		local old=pnl.Paint;
		pnl.Paint=function(s,w,h)
			if s:IsHovered() then
				setcol(getcol("black"));
			else
				setcol(getcol("blackerer"));
			end
			rect(0,0,w,h);
			setcol(getcol("blacker"));
			olrect(0,0,w,h);
			old(s,w,h);
			if s.active then
				setcol(self.job.color);
				olrect(0,0,w,h);
			end
		end
		pnl.DoClick=function(s)
			self.mdl=mdls[i];
			self:setupmodel();
			local kids=self.rpicker:GetChildren();
			for i=1,#kids do kids[i].active=false; end
			s.active=true;
		end
	end
end

function panel:mkright()
	self.rtitle=vguicreate("cl_dbutton",self.right);
	self.rtitle:Dock(TOP);
	self.rtitle:DockMargin(0,1,0,0);
	self.rtitle.Paint=function(s,w,h)
		setcol(getcol("blacker"));
		rect(0,0,w,h);
		setcol(getcol("black"));
		olrect(0,0,w,h);
		s:SetFont(scale("rw",h));
	end
	local rightw,righth=self.right:GetSize();
	local btnh=self.rtitle:GetTall();

	self.rscroll=vguicreate("cl_dscrollpanel",self.right);
	self.rscroll:Dock(TOP);
	self.rscroll:SetTall(righth-(btnh*4)-8);
	self.rscroll.Paint=nil;
	local scrollh=self.rscroll:GetTall();

	self.rdesc=self.rscroll:Add("cl_dlabel");
	self.rdesc:SetFont("rw18");
	self.rdesc:Dock(TOP);
	self.rdesc:DockMargin(0,1,0,0);
	self.rdesc:SetTall(scrollh);
	self.rdesc.Paint=function(s,w,h)
		if !self.job then return; end
		setcol(self.job.color);
		rect(0,0,w,1);
		rect(0,h-1,w,1);
	end

	self.rpicker=vguicreate("cl_dpanel",self.right);
	self.rpicker:Dock(TOP);
	self.rpicker:DockMargin(0,1,0,0);
	self.rpicker:SetTall(btnh*2);
	self.rpicker.Paint=nil;

	self.rselect=vguicreate("cl_dbutton",self.right);
	self.rselect:Dock(TOP);
	self.rselect:SetText("Select");
	self.rselect:DockMargin(0,1,0,0);

	self.rmodel=self.rscroll:Add("DModelPanel");
	self.rmodel:Dock(TOP);
	self.rmodel:DockMargin(0,1,0,0);
	self.rmodel:SetTall(scrollh);
	self.rmodel.LayoutEntity=function() return; end
	local old=self.rmodel.Paint;
	self.rmodel.Paint=function(s,w,h)
		setcol(getcol("blackerer"));
		rect(0,0,w,h);
		setcol(getcol("blacker"));
		olrect(0,0,w,h);
		old(s,w,h);
	end
end

function panel:Init()
	self:Dock(FILL);
	local w,h=self:GetSize();

	self.left=vguicreate("cl_dscrollpanel",self);
	self.left:SetWide(w/2-12);
	self.left:Dock(LEFT);
	self.left:DockMargin(8,8,8,8);
	self.left.Paint=nil;
	self:mkleft();

	self.right=vguicreate("cl_dpanel",self);
	self.right:SetWide(w/2-12);
	self.right:Dock(LEFT);
	self.right:DockMargin(0,8,0,8);
	self.right.Paint=nil;
	self:mkright();
end

function panel:Paint()
end
ui.add("cl_jobs",panel,"cl_dpanel");