if !item.enabled then return; end
local info      = {};
info.name       = "poor lockpick";
info.mdl        = "models/weapons/w_crowbar.mdl";
info.category   = "tool";
info.materials  =
{
	metal = 3
};
item.add(info);