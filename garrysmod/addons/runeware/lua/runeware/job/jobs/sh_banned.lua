if !job.enabled then return; end
local JOB       = {};
JOB.name        = "banned";
JOB.team        = JOB.name;
JOB.description = "You are absolute trash.";
JOB.color       = color.get("brown");
JOB.models      =
{
	"models/player/soldier_stripped.mdl"
};
JOB.loadout     =
{

};
JOB.spawns      =
{
	Vector(1955,-3941,616)
};
job.add(JOB);