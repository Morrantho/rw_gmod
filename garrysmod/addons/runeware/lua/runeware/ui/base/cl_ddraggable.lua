if !ui.enabled then return; end
local scrw,scrh=ScrW,ScrH;
local abs=math.abs;
local clamp=math.Clamp;
local uivisible=gui.IsGameUIVisible;
local mousepos=gui.MousePos;
local mousedown=input.IsMouseDown;
local mouseleft=MOUSE_LEFT;
local mousex,mousey=gui.MouseX,gui.MouseY;
local setcursorpos=input.SetCursorPos;

local panel={};

function panel:Init()
	self.pressed=false;
	self.unpressed=false;
	self.ddraggable=true;
end

function panel:inbounds(mx,my)
	local x,y,w,h=self:GetBounds();
	return mx>x&&mx<x+w&&my>y&&my<y+h;
end
-- this is like 3 functions smashed into big fucktion.
-- it doesnt resolve multiple collisions. it tries, but
-- fails, since they cancel each other out with setpos.
-- feel free to figure out the math for that, im done with this for
-- the moment. - pyg
function panel:resolve()
	local mx=clamp(mousex(),1,scrw()-1);
	local my=clamp(mousey(),1,scrh()-1);
	local x=clamp(mx-self.dragx,0,scrw()-self:GetWide());
	local y=clamp(my-self.dragy,0,scrh()-self:GetTall());
	self:SetPos(x,y);
	local kids=vgui.GetWorldPanel():GetChildren();
	for i=1,#kids do
		if !IsValid(kids[i])||!ispanel(kids[i])||kids[i]==self then continue; end--gtfo
		if !kids[i].ddraggable then continue; end--dont collide with shit thats not a ddraggable.
		local w,h=self:GetSize();
		local px,py,pw,ph=kids[i]:GetBounds();
		local left,top,right,bottom=px-(x+w),py-(y+h),x-(px+pw),y-(py+ph);
		if (left>0||top>0)||(right>0||bottom>0) then continue; end-- not colliding on either axis
		local xo,yo=0,0;--min penetration per axis
		--these branches are cancer. if someone wants to chuck the verts in an array, or math.min(all,the,fucking,sides)
		--and not break the penetration distances in less lines, go ahead.
		if left>top&&left>right&&left>bottom then
			xo=left;
		elseif top>left&&top>right&&top>bottom then
			yo=top;
		elseif right>left&&right>top&&right>bottom then
			xo=abs(right);
		elseif bottom>left&&bottom>top&&bottom>right then
			yo=abs(bottom);
		end
		setcursorpos(mx+xo,my+yo);
	end
end

function panel:handlemouse()
	local mx,my=mousepos();
	if uivisible() then return; end	
	if self:inbounds(mx,my) then
		self:SetCursor("hand");
		local down=mousedown(mouseleft);
		if down&&!self.pressed&&!panel.cur then
			self:OnMousePressed();
			self.pressed=true;
			self.unpressed=false;
		elseif !down&&self.pressed&&!self.unpressed then
			self:OnMouseReleased();
			self.pressed=false;
			self.unpressed=true;
		end
	end
end

function panel:OnMousePressed()
	self.dragx=mousex()-self.x;
	self.dragy=mousey()-self.y;
	panel.cur=self;
end

function panel:OnMouseReleased()
	self.dragx=nil;
	self.dragy=nil;
	panel.cur=nil;
end

function panel:Think()
	self:handlemouse();
	if self.dragx&&self.dragy then
		self:resolve();
	end
end
ui.add("cl_ddraggable",panel,"cl_dpanel");