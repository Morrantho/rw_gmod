if !item.enabled then return; end
local info            = {};
info.name       = "epic lockpick";
info.mdl        = "models/weapons/w_crowbar.mdl";
info.category   = "tool";
info.materials  =
{
	["rare lockpick"] = 1,
	["metal"] = 4,
};
item.add(info);