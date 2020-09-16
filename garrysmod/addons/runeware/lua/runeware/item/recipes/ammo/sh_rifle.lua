if !item.enabled then return; end
local info            = {};
info.name       = "rifle ammo";
info.mdl        = "models/Items/BoxMRounds.mdl";
info.category   = "ammo";
info.materials  =
{
	metal = 15,
};
item.add(info);