if !item.enabled then return; end
local info={};
info.name="epic cracker";
info.mdl="models/weapons/w_c4.mdl";
info.category="tool";
info.materials=
{
	["rare cracker"]=5,
	metal=4,
	plastic=4
};
item.add(info);