if !item.enabled then return; end
local info            = {};
info.name       = "uncommon lockpick";
info.mdl        = "models/weapons/w_crowbar.mdl";
info.category   = "tool";
info.materials  =
{
	["common lockpick"] = 1,
	["metal"] = 2,
};
item.add(info);