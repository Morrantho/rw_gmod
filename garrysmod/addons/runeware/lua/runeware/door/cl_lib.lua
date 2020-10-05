if !door.enabled then return; end
local readuint=net.ReadUInt;
local camstart    = cam.Start3D2D;
local camend      = cam.End3D2D;
local drawtext    = draw.SimpleText;
local drawtextol  = draw.SimpleTextOutlined;
local getcolor    = color.get;
local localplayer = LocalPlayer;
local getbyindex  = ents.GetByIndex;
local hookadd=hook.Add;
local clamp=math.Clamp;
local lerp=Lerp;
local vec=Vector;

local function rendercost(DOOR,alpha)
	if DOOR:isdoorunownable() then return; end
	local col=Color(255,255,255,alpha);
	drawtext("For Sale: $"..DOOR:getdoorcost(),"rw192",0,256,col,1,1);
end

local function renderowners(DOOR,alpha)
	local owners=DOOR:getdoorowners();
	if #owners<1 then
		rendercost(DOOR,alpha);
	else
		for i=1,#owners do
			local pl=owners[i];
			if !IsValid(pl) then continue; end
			local name=pl:getname();
			local jobcol=pl:getjob().color;
			col=Color(jobcol.r,jobcol.g,jobcol.b,alpha);
			drawtext(name,"rw192",0,i*256,col,1,1);
		end
	end
end

function door.prop_door_rotating(DOOR,dist)
	local pos,ang=DOOR:GetPos(),DOOR:GetAngles();
	local alpha=255-(dist/door.distance)*255;
	local col=Color(255,255,255,alpha);
	local title=DOOR:getdoor()[2];
	local siz=DOOR:OBBMaxs()-DOOR:OBBMins();	
	ang:RotateAroundAxis(ang:Forward(),90);
	ang:RotateAroundAxis(ang:Right(),90);
	local d=ang:Up()*siz.x/4;--depth
	local w=ang:Forward()*-siz.y/2;--width
	local h=ang:Right()*-siz.z/4;--height

	camstart(pos+d+w+h,ang,0.02);
	if door.dbg then
		drawtext(DOOR:EntIndex(),"rwheading256",0,-256,col,1,1);
	end
	drawtext(title,"rwheading256",0,0,col,1,1);
	renderowners(DOOR,alpha);
	camend();

	ang:RotateAroundAxis(ang:Right(),180);
	camstart(pos+-d+w+h,ang,0.02);
	if door.dbg then
		drawtext(DOOR:EntIndex(),"rwheading256",0,-256,col,1,1);
	end	
	drawtext(title,"rwheading256",0,0,col,1,1);
	renderowners(DOOR,alpha);
	camend();
end

function door.func_door(DOOR,dist)
	local pos,ang=DOOR:GetPos(),DOOR:GetAngles();
	local alpha=255-(dist/door.distance)*255;
	local col=Color(255,255,255,alpha);
	local title=DOOR:getdoor()[2];
	local siz=DOOR:OBBMaxs()-DOOR:OBBMins();	
	ang:RotateAroundAxis(ang:Forward(),90);
	local d=ang:Up()*siz.y/2;--depth
	local w=vec(0,0,0);
	local h=ang:Right()*-siz.z/4;
	local o=vec(0,0,0);
	if siz.x<siz.y then
		ang:RotateAroundAxis(ang:Right(),90);
		d=vec(0,0,0);--w
		w=ang:Up()*siz.x/2;--d
	end
	camstart(pos+d+w+h,ang,0.02);
	if door.dbg then
		drawtext(DOOR:EntIndex(),"rwheading256",0,-256,col,1,1);
	end
	drawtext(title,"rwheading256",0,0,col,1,1);
	renderowners(DOOR,alpha);
	camend();
	if siz.x<siz.y then
		w=-w;
	else
		d=-d;
	end
	ang:RotateAroundAxis(ang:Right(),180);
	camstart(pos+d+w+h,ang,0.02);
	if door.dbg then
		drawtext(DOOR:EntIndex(),"rwheading256",0,-256,col,1,1);
	end	
	drawtext(title,"rwheading256",0,0,col,1,1);
	renderowners(DOOR,alpha);
	camend();
end

function door.func_door_rotating(DOOR,dist)
	door.prop_door_rotating(DOOR,dist);
end

function door.PostDrawTranslucentRenderables()
	local pl = localplayer();
	for a,b in pairs(door.doors) do
		local DOOR=getbyindex(a);
		if !IsValid(DOOR)||!DOOR:isdoor() then continue; end
		local dist=pl:GetPos():DistToSqr(DOOR:GetPos());
		if dist>door.distance then continue; end
		door[DOOR:GetClass()](DOOR,dist);
	end
end
hookadd("PostDrawTranslucentRenderables","door.PostDrawTranslucentRenderables",door.PostDrawTranslucentRenderables);

cache.register({
	name="doors",
	add=function(varid,ent,cached)	
		if !cached[varid] then cached[varid]={}; end
		cached[varid][readuint(6)]=readuint(3);
	end,
	remove=function(varid,ent,cached,data)
		cached[varid][readuint(6)]=nil;
	end
});