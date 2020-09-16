if !item.enabled then return; end
local info            = {};
info.name       = "epic repair kit";
info.mdl        = "models/props_junk/cardboard_box004a.mdl";
info.category   = "tool";
info.materials  =
{
	["plastic"] = 40,
	["metal"]   = 40,
};
item.add(info);