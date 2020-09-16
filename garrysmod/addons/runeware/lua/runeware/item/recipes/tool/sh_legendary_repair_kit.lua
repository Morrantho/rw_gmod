if !item.enabled then return; end
local info            = {};
info.name       = "legendary repair kit";
info.mdl        = "models/props_junk/cardboard_box004a.mdl";
info.category   = "tool";
info.materials  =
{
	["plastic"] = 60,
	["metal"]   = 60,
};
item.add(info);