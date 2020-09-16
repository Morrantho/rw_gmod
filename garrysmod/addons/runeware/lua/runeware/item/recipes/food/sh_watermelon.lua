if !item.enabled then return; end
local info            = {};
info.name       = "watermelon";
info.mdl        = "models/props_junk/watermelon01.mdl";
info.category   = "food";
info.materials  =
{
	["bottle of water"] = 1,
	["potato"] = 1
};
item.add(info);