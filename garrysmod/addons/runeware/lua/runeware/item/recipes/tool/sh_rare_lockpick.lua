if !item.enabled then return; end
local info            = {};
info.name       = "rare lockpick";
info.mdl        = "models/weapons/w_crowbar.mdl";
info.category   = "tool";
info.materials  = 
{
	["uncommon lockpick"] = 1,
	["metal"] = 3,
};
item.add(info);