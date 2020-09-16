if !admin.enabled then return; end
local hookadd=hook.Add;
local vec=Vector;
local valid=IsValid;

function admin.PhysgunPickup(pl,ent)
	return ent.owner==pl;
end
hookadd("PhysgunPickup","admin.PhysgunPickup",admin.PhysgunPickup);

function admin.OnPhysgunPickup(pl,ent)
	admin.ghostent(ent,true,20,admin.propghostmaterial,admin.propghostcolor);
end
hookadd("OnPhysgunPickup","admin.OnPhysgunPickup",admin.OnPhysgunPickup);

function admin.PhysgunDrop(pl,ent)
	local phys=ent:GetPhysicsObject();
	if !valid(phys) then return; end
	phys:SetVelocity(vec(0,0,0));
	phys:AddAngleVelocity(phys:GetAngleVelocity()*-1);
end
hookadd("PhysgunDrop","admin.PhysgunDrop",admin.PhysgunDrop);

function admin.CanPlayerUnfreeze(pl,ent,phys)
	return ent.owner==pl;
end
hookadd("CanPlayerUnfreeze","admin.CanPlayerUnfreeze",admin.CanPlayerUnfreeze);

function admin.OnPhysgunFreeze(wep,phys,ent,pl)
	if ent.owner==pl then
		admin.ghostent(ent,false,0,""); -- this is the only time this should happen.
		return true;
	end
	return false;
end
hookadd("OnPhysgunFreeze","admin.OnPhysgunFreeze",admin.OnPhysgunFreeze);

function admin.OnPhysgunReload(pl)
	return false;
end
hookadd("OnPhysgunReload","admin.OnPhysgunReload",admin.OnPhysgunReload);