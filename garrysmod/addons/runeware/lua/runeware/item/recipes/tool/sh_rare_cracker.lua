if !item.enabled then return; end
local info            = {};
info.name       = "rare cracker";
info.mdl        = "models/weapons/w_c4.mdl";
info.category   = "tool";
info.materials  =
{
	["uncommon cracker"] = 4,
	metal   = 3,
	plastic = 3
};
item.add(info);