if !item.enabled then return; end
local info      = {};
info.name       = "emp";
info.mdl        = "models/weapons/w_eq_smokegrenade.mdl";
info.category   = "grenade";
info.materials  =
{
	["plastic"] = 40,
	["metal"]   = 40,
};
item.add(info);