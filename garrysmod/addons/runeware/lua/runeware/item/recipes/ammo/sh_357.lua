if !item.enabled then return; end
local info      = {};
info.name       = "357 ammo";
info.mdl        = "models/Items/357ammo.mdl";
info.category   = "ammo";
info.materials  =
{
	metal = 30,
};
item.add(info);