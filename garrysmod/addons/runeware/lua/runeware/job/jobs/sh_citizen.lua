if !job.enabled then return; end
local JOB       = {};
JOB.name        = "citizen";
JOB.team        = "civilians";
JOB.description = "Live life to its fullest.";
JOB.color       = color.get("green");
JOB.limit=0;
JOB.models      =
{
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_05.mdl",
	"models/player/group01/female_06.mdl",

	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",

	"models/player/group02/male_02.mdl",
	"models/player/group02/male_04.mdl",
	"models/player/group02/male_06.mdl",
	"models/player/group02/male_08.mdl",

	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_05.mdl",
	"models/player/group03/female_06.mdl",
	
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
};
JOB.loadout     =
{
	"weapon_physgun",
	"weapon_physcannon",
	"weapon_hands",	
	"gmod_tool",
};
JOB.spawns      =
{
	Vector(2878,-2815,824),
	Vector(2880,-2561,824),
	Vector(2754,-2561,824),
	Vector(2753,-2813,824),
	Vector(2624,-2561,824),
	Vector(2625,-2813,824),
	Vector(2497,-2815,824),
	Vector(2497,-2562,824),
	Vector(2368,-2562,824),
	Vector(2366,-2816,824),
	Vector(2238,-2815,824),
	Vector(2238,-2558,824),
};
job.add(JOB);