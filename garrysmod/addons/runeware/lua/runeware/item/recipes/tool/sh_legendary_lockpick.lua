if !item.enabled then return; end
local info            = {};
info.name       = "legendary lockpick";
info.mdl        = "models/weapons/w_crowbar.mdl";
info.category   = "tool";
info.materials  =
{
	["epic lockpick"] = 1,
	["metal"] = 5,
};
item.add(info);