if !item.enabled then return; end
local info      = {};
info.name       = "rare repair kit";
info.mdl        = "models/props_junk/cardboard_box004a.mdl";
info.category   = "tool";
info.materials  =
{
	["plastic"] = 20,
	["metal"]   = 20,
};
item.add(info);