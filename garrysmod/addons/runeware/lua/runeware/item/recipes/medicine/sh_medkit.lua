if !item.enabled then return; end
local info            = {};
info.name       = "medkit";
info.mdl        = "models/Items/HealthKit.mdl";
info.category   = "medicine";
info.materials  =
{
	["bottle of water"] = 1,
	["garry berries"] = 5,
	metal = 3,
	glass = 1
};
item.add(info);