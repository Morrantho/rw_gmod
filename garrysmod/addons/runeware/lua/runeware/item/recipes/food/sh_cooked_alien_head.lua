if !item.enabled then return; end
local info     = {};
info.name      = "cooked alien head";
info.category  = "food";
info.mdl       = "models/gibs/antlion_gib_large_2.mdl";
info.materials =
{
	["raw alien meat"] = 1,
	["raw alien claw"] = 1,
	["raw alien tendril"] = 1
}
item.add(info);