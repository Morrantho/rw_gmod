if !item.enabled then return; end
local info            = {};
info.name       = "uncommon repair kit";
info.mdl        = "models/props_junk/cardboard_box004a.mdl";
info.category   = "tool";
info.materials  =
{
	["plastic"] = 10,
	["metal"]   = 10,
};
item.add(info);