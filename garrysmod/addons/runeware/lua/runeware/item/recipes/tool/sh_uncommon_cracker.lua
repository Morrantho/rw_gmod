if !item.enabled then return; end
local info            = {};
info.name       = "uncommon cracker";
info.mdl        = "models/weapons/w_c4.mdl";
info.category   = "tool";
info.materials  =
{
	["common cracker"] = 3,
	metal   = 2,
	plastic = 2,
};
item.add(info);