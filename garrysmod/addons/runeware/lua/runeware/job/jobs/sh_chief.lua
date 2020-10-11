if !job.enabled then return; end
local JOB       = {};
JOB.name        = "chief";
JOB.team        = "civil protection";
JOB.description = "Coordinate cops.";
JOB.color       = color.get("indigo");
JOB.limit=1;
JOB.models      =
{
	"models/player/barney.mdl"
};
JOB.loadout     =
{
	"weapon_physgun",
	"weapon_physcannon",
	"weapon_hands",
	"gmod_tool",
	"weapon_baton",
};
JOB.spawns      = 
{
	Vector(2491,449,1504)
};
job.add(JOB);