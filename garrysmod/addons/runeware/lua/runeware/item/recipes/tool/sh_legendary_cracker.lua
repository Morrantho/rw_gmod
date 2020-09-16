if !item.enabled then return; end
local info            = {};
info.name       = "legendary cracker";
info.mdl        = "models/weapons/w_c4.mdl";
info.category   = "tool";
info.materials  =
{
	["epic cracker"] = 6,
	metal   = 5,
	plastic = 5
};
item.add(info);