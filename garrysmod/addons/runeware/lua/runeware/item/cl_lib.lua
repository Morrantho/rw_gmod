if !item.enabled then return; end
local netreceive=net.Receive;
local readuint=net.ReadUInt;
local entbyindex=ents.GetByIndex;
local camstart=cam.Start3D2D;
local camend=cam.End3D2D;
local drawtext=draw.SimpleText;
local drawoltext=draw.SimpleTextOutlined;
local floor=math.floor;
local clamp=math.Clamp;
local Color=Color;
local lerp=Lerp;
local localplayer=LocalPlayer;

function item.init()
	local entidx=readuint(13);
	local itemid=readuint(8);
	local quantity=readuint(7);
	local durability=readuint(7);
	wait.now(.1,function() -- gotta wait for src to nw the ent since this happens on spawn.
		local ent=entbyindex(entidx);
		ent.itemid=itemid;
		ent.quantity=quantity;
		ent.durability=durability;
		ent.itemname=item[itemid].name;
	end);
end
netreceive("item_init",item.init);

function item.draw(ent)
	local pl=localplayer();
	local pos=ent:GetPos();
	local eye=pl:EyeAngles();
	local dist=pl:GetPos():DistToSqr(pos);
	local height=ent:OBBMaxs().z-ent:OBBMins().z;
	if dist>50000 then return; end
	local ang=Angle(0,eye.y,0);
	local itemname=ent.itemname;
	ang:RotateAroundAxis(ang:Forward(),90);
	ang:RotateAroundAxis(ang:Right(),90);
	local base=color.get("whitest");
	local ol=color.get("blackest");
	local alpha=255-(dist/door.distance)*255;
	local truecol=Color(base.r,base.g,base.b,alpha);
	local trueolcol=Color(ol.r,ol.g,ol.b,alpha);
	camstart(pos-ang:Right()*height,ang,.03);
	-- drawtext(itemname,"rw256",0,0,truecol,1,1);
	drawoltext(itemname,"rw256",0,0,truecol,1,1,4,trueolcol);
	camend();
end