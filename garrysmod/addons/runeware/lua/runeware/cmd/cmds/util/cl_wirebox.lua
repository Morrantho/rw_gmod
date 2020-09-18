if !cmd.enabled then return; end
local wirebox=render.DrawWireframeBox;
local vec=Vector;
local ang=Angle;
local getcol=color.get;
local hookadd=hook.Add;
local hookremove=hook.Remove;
local min,max=-1024,1024;

local CMD       = {};
CMD.name        = "wirebox";
CMD.usage       = "wirebox";
CMD.description = "Used for sizing 3D AABBs";
CMD.power       = role.developer;
CMD.enabled     = false;

local _ang=ang(0,0,0);
local _mins=vec(-8,-8,-8);
local _maxs=vec(8,8,8);
local _col=nil;
local _cvars={};
local _pnl=nil;

local function render_wirebox()
	if !_col then _col=getcol("whitest"); end
	local pos=vec(_cvars[1]:GetInt(),_cvars[2]:GetInt(),_cvars[3]:GetInt());
	local mins=vec(_cvars[4]:GetInt(),_cvars[5]:GetInt(),_cvars[6]:GetInt());
	local maxs=vec(_cvars[7]:GetInt(),_cvars[8]:GetInt(),_cvars[9]:GetInt());
	wirebox(
		CMD.pos+pos,
		_ang,
		_mins+mins,
		_maxs+maxs,
		_col,
		true
	);
end

local function mkpnl()
	local scrw,scrh=ScrW(),ScrH();
	local w,h=scrw/4,scrh;
	local x,y=scrw-w,0;
	_pnl=vgui.Create("DFrame");
	_pnl:SetSize(w,h);
	_pnl:SetPos(x,y);
	-- Position
	local pos=vgui.Create("DForm",_pnl);
	pos:Dock(TOP);
	pos:SetName("Position");
	local sliders={"x","y","z"};
	for i=1,#sliders do
		local s=sliders[i];
		local name="wirebox_"..s;
		_cvars[#_cvars+1]=CreateClientConVar(name,"0",false,false,"",min,max);
		pos:NumSlider(s,name,min,max,0);
	end
	-- Mins
	local mins=vgui.Create("DForm",_pnl);
	mins:Dock(TOP);
	mins:SetName("Mins");
	for i=1,#sliders do
		local s=sliders[i];
		local name="wirebox_min"..s;
		_cvars[#_cvars+1]=CreateClientConVar(name,"0",false,false,"",min,max);
		mins:NumSlider(s,name,min,max,0);
	end
	-- Maxs
	local maxs=vgui.Create("DForm",_pnl);
	maxs:Dock(TOP);
	maxs:SetName("Maxs");
	for i=1,#sliders do
		local s=sliders[i];
		local name="wirebox_max"..s;
		_cvars[#_cvars+1]=CreateClientConVar(name,"0",false,false,"",min,max);
		maxs:NumSlider(s,name,min,max,0);
	end
end

local function rmpnl()
	if IsValid(_pnl) then _pnl:Remove(); end
	_pnl=nil;
	for i=1,#_cvars do _cvars[i]:Revert(); end
end

function CMD.run(pl,args,argstr)
	CMD.enabled=!CMD.enabled;
	if CMD.enabled then
		CMD.pos=pl:EyePos();
		CMD.ang=ang(0,0,0);
		CMD.mins=vec(-8,-8,-8);
		CMD.maxs=vec(8,8,8);
		CMD.col=color.get("whitest");
		hookadd("PostDrawTranslucentRenderables","render_wirebox",render_wirebox);
		mkpnl();
	else
		hookremove("PostDrawTranslucentRenderables","render_wirebox");
		rmpnl();
	end
end
cmd.add(CMD);