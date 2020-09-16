if !item.enabled then return; end
local info      = {};
info.name       = "jar of pills";
info.mdl        = "models/props_lab/jar01b.mdl";
info.category   = "medicine";
info.materials  =
{
	["bottle of water"] = 1,
	plastic = 1,
};
item.add(info);