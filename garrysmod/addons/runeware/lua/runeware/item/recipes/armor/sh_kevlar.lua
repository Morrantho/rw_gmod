if !item.enabled then return; end
local info      = {};
info.name       = "kevlar";
info.mdl        = "models/props_c17/consolebox05a.mdl";
info.category   = "armor";
info.materials  =
{
	["metal"]   = 10,
};
item.add(info);