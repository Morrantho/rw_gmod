if !item.enabled then return; end
local info            = {};
info.name       = "medical vial";
info.mdl        = "models/healthvial.mdl";
info.category   = "medicine";
info.materials  =
{
	["bottle of water"] = 1,
	["garry berries"] = 3,
	glass = 1
};
item.add(info);