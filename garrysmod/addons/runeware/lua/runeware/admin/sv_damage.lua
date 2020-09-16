if !admin.enabled then return; end
local hookadd=hook.Add;

function admin.EntityTakeDamage(ent,dmg)
	if ent:hasstatus("graced") then return true; end
	if ent:hasstatus("ghosted") then return true; end
	local atk=dmg:GetAttacker();
	if admin.explodables[ent:GetClass()] then dmg:SetDamage(0); end
	return false;
end
hookadd("EntityTakeDamage","admin.EntityTakeDamage",admin.EntityTakeDamage);

function admin.PlayerShouldTakeDamage(pl,atk)
	if atk:hasstatus("ghosted") then return false; end
	if pl:hasstatus("graced") then return false; end
	if admin.nondamagables[atk:GetClass()] then return false; end
	return true;
end
hookadd("PlayerShouldTakeDamage","admin.PlayerShouldTakeDamage",admin.PlayerShouldTakeDamage);

function admin.GetFallDamage(pl,spd)
	if pl:hasstatus("graced") then return 0; end
	return spd/8;
end
hookadd("GetFallDamage","admin.GetFallDamage",admin.GetFallDamage);