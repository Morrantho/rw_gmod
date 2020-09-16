if !admin.enabled then return; end
admin.defaultrole       = role.member;
admin.defaultmoney      = 10000;
admin.proplimit         = 120;
admin.propspawndelay    = 1;
admin.propghostmaterial = "models/debug/debugwhite";
admin.propghostcolor    = color.get("white");
admin.proplimits        =
{
	[role.banned]       = 0,
	[role.member]       = 60,
	[role.moderator]    = 80,
	[role.admin]        = 100,
};
admin.banunits          = -- these are 1:1 sql timeunits / intervals.
{
	minute  = role.moderator,
	hour    = role.moderator,
	day     = role.moderator,
	week    = role.admin,
	month   = role.admin,
	quarter = role.headadmin, -- 3 months
	year    = role.superadmin
};
admin.banaliases =
{
	m  = "minute",
	h  = "hour",
	d  = "day",
	w  = "week",
	mo = "month",
	q  = "quarter",
	y  = "year"
};
admin.bantimes =
{
	[role.moderator] =
	{
		minute = 10080,
		hour   = 168,
		day    = 7,
	},
	[role.admin] =
	{
		minute = 44640,
		hour   = 744,
		day    = 31,
		week   = 4,
		month  = 1,
	},
	[role.headadmin] =
	{
		minute  = 525600,
		hour    = 8760,
		day     = 356,
		week    = 52,
		month   = 12,
		quarter = 4,
	},
}
admin.defaults          =
{
	["STEAM_0:0:18578874"] = role.root,
	["STEAM_0:0:49762132"] = role.developer,
};
admin.nondamagables     = -- entities that shouldn't inflict damage
{
	prop_physics = true,
	gmod_wheel   = true,	
};
admin.explodables       = -- props that explode, but shouldn't
{
	["models/props_phx/misc/flakshell_big.mdl"] = true,
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/props_junk/gascan001a.mdl"] = true,
	["models/props_junk/propane_tank001a.mdl"] = true,
	["models/props_junk/PropaneCanister001a.mdl"] = true,
	["models/props_phx/oildrum001_explosive.mdl"] = true,
	["models/props_phx/mk-82.mdl"] = true,
	["models/props_phx/ww2bomb.mdl"] = true,
	["models/props_phx/amraam.mdl"] = true,
	["models/props_phx/torpedo.mdl"] = true,
	["models/props_phx/misc/flakshell_big.mdl"] = true
};
admin.bannedtools = -- tools that do nothing when used
{
	eyeposer    = true,
	faceposer   = true,
	fingerposer = true,
	inflator    = true,
	paint       = true,
	trails      = true
}