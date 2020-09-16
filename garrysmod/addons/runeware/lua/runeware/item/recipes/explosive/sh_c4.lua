if !item.enabled then return; end
local info      = {};
info.name       = "c4";
info.mdl        = "models/weapons/w_c4.mdl";
info.category   = "explosive";
info.materials  =
{
	["plastic"] = 100,
	["metal"]   = 100,
};
item.add(info);