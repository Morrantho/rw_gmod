if !level.enabled then return; end
local readuint=net.ReadUInt;

cache.register({
	name="level",
	set=function(varid,ent,cached)
		cached[varid]=readuint(8);
	end
});

cache.register({
	name="xp",
	set=function(varid,ent,cached)
		cached[varid]=readuint(11);
	end
});