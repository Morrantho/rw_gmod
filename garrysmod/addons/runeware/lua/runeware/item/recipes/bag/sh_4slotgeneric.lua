if !item.enabled then return; end
local info      = {};
info.slots      = 4;
info.name       = "4 slot bag";
info.mdl        = "models/props_junk/garbage_bag001a.mdl";
info.category   = "bag";
info.materials  =
{
	["leather"] = 10,
};
item.add(info);