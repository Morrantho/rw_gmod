if !item.enabled then return; end
local info            = {};
info.name       = "common repair kit";
info.mdl        = "models/props_junk/cardboard_box004a.mdl";
info.category   = "tool";
info.materials  =
{
	["plastic"] = 5,
	["metal"]   = 5,
};
item.add(info);