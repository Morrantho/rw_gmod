if !ui.enabled then return; end
local setcolor         = surface.SetDrawColor;
local getcolor         = color.get;
local drawrect         = surface.DrawRect;
local drawoutlinedrect = surface.DrawOutlinedRect;
local scrw,scrh        = ScrW,ScrH;
local vguicreate       = vgui.Create;
local entbyindex       = ents.GetByIndex;
local scale=font.scale;
local floor=math.floor;

local panel = {};
-- todo: make this exist on panel metatable
function panel:dequeue()
	prompt.dequeue(self);
end

function panel:Init()
	local sw,sh=scrw(),scrh();
	local w,h=sw/5,sh/7;
	local navh=self.nav:GetTall();
	self:SetSize(w,h);

	self.body=vguicreate("cl_dpanel",self);
	self.body:Dock(TOP);
	self.body:SetTall(h-(navh*2));
	self.body.Paint=nil;

	self.text=vguicreate("cl_dlabel",self.body);
	self.text:Dock(FILL);
	self.text.Paint=function(s,w,h)
		s:SetFont(scale("rw",h/2.65));
	end

	self.response=vguicreate("cl_dpanel",self);
	self.response:Dock(TOP);
	self.response:SetTall(navh);
	self.response.Paint = nil;

	self.close.DoClick = function()
		if self.onclose then self.onclose(); end
		self:dequeue();
	end

	self.yes = vguicreate("cl_dbutton",self.response);
	self.yes:Dock(LEFT);
	self.yes:SetText("Yes");
	self.yes:SetWide(w/2);
	self.yes.DoClick = function()
		if self.onyes then self.onyes(); end
		prompt.dequeue(self);
	end

	self.no  = vguicreate("cl_dbutton",self.response);
	self.no:Dock(LEFT);
	self.no:SetText("No");
	self.no:SetWide(w/2);
	self.no.DoClick = function()
		if self.onno then self.onno(); end
		prompt.dequeue(self);
	end
	self:Center();
end
ui.add("cl_yesno",panel,"cl_dframe");