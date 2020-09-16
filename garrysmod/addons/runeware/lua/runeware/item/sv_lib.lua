if !item.enabled then return; end
local entscreate = ents.Create;
local nwstring   = util.AddNetworkString;
local netstart   = net.Start;
local netall     = net.Broadcast;
local writeuint  = net.WriteUInt;
nwstring("item_init");

function item.init(ent,_item,quantity)
	ent.itemname=_item.name;
	ent.itemid=item[_item.name];
	ent.quantity=quantity||1;
	ent.durability=_item.durability||0;
end

function item.send(ent,_item,quantity)
	netstart("item_init");
	writeuint(ent:EntIndex(),13); -- 0-8191 entindex
	writeuint(item[_item.name],8); -- 0-255 itemid
	writeuint(quantity,7); -- 0-127 quantity
	writeuint(ent.durability||0,7); -- 0-127 durability
	netall();
end

function item.spawn(pos,_item,quantity)
	local ent=entscreate("ent_item");
	ent:Spawn();
	ent:SetPos(pos);
	ent:SetModel(_item.mdl);
	ent:PhysicsInit(SOLID_VPHYSICS);
	ent:SetMoveType(MOVETYPE_VPHYSICS);
	ent:SetSolid(SOLID_VPHYSICS);
	ent:SetUseType(SIMPLE_USE);
	ent:SetCollisionGroup(20);
	local phys=ent:GetPhysicsObject();
	if IsValid(phys) then phys:Wake(); end
	item.init(ent,_item,quantity);
	item.send(ent,_item,quantity);
end