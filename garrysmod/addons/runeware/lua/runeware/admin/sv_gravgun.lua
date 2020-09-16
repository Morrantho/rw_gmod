if !admin.enabled then return; end
local hookadd=hook.Add;

function admin.GravGunPunt(p,ent)
	return false;
end
hookadd("GravGunPunt","admin.GravGunPunt",admin.GravGunPunt);