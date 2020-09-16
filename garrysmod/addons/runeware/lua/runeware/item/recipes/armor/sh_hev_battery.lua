if !item.enabled then return; end
local info      = {};
info.name       = "hev battery";
info.mdl        = "models/Items/battery.mdl";
info.category   = "armor";
info.materials  =
{
	["car battery"] = 1,
	["combine metal"] = 2
};
item.add(info);