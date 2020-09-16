if !item.enabled then return; end
local info      = {};
info.name       = "legendary ak47";
info.mdl        = "models/weapons/w_rif_ak47.mdl";
info.category   = "weapon";
info.materials  =
{
	["plastic"] = 100,
	["metal"]   = 100,
};
item.add(info);