if !item.enabled then return; end
local info            = {};
info.name       = "shotgun ammo";
info.mdl        = "models/Items/BoxBuckshot.mdl";
info.category   = "ammo";
info.materials  =
{
	metal = 20,
};
item.add(info);