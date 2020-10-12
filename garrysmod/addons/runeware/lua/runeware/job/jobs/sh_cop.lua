if !job.enabled then return; end
local vec=Vector;

local JOB       = {};
JOB.name        = "cop";
JOB.team        = "civil protection";
JOB.description = "Arrest baddies.";
JOB.color       = color.get("blue");
JOB.limit=0;
JOB.models      =
{
	"models/player/police.mdl",
	"models/player/police_fem.mdl"
};
JOB.loadout     =
{
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
	"weapon_hands",	
	"weapon_baton",
};
JOB.spawns      = 
{
	vec(1867,-951,2256),
	vec(1979,-878,2256),
	vec(1875,-780,2256),
	vec(2033,-759,2256),
	vec(1866,-603,2256),
	vec(2041,-602,2256),
	vec(2044,-476,2256),
	vec(1899,-472,2256),
};
job.add(JOB);