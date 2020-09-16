if !job.enabled then return; end
local JOB       = {};
JOB.name        = "mayor";
JOB.team        = "civil protection";
JOB.description = "Run that city.";
JOB.color       = color.get("red");
JOB.models      =
{
	"models/player/breen.mdl",
	"models/player/magnusson.mdl",
};
JOB.loadout     =
{
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
	"weapon_hands",
};
JOB.spawns      =
{
	Vector(1468,-1543,1717)
};
job.add(JOB);