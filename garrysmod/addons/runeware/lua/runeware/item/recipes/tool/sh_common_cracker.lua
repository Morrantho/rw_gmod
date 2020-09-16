if !item.enabled then return; end
local info      = {};
info.name       = "common cracker";
info.mdl        = "models/weapons/w_c4.mdl";
info.category   = "tool";
info.materials  =
{
	metal   = 2,
	plastic = 1
};
item.add(info);