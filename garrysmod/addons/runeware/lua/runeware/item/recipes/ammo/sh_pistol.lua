if !item.enabled then return; end
local info            = {};
info.name       = "pistol ammo";
info.mdl        = "models/Items/BoxSRounds.mdl";
info.category   = "ammo";
info.materials  =
{
	metal = 10,
};
item.add(info);