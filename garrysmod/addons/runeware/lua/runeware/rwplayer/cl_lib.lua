if !rwplayer.enabled then return; end
local readuint=net.ReadUInt;
local readstr=net.ReadString;
local readbool=net.ReadBool;

cache.register({
	name="money",
	set=function(varid,ent,cached)
		cached[varid]=readuint(30);
	end
});

cache.register({
	name="name",
	set=function(varid,ent,cached)
		cached[varid]=readstr();
	end
});

cache.register({
	name="usermode",
	set=function(varid,ent,cached)
		cached[varid]=readuint(8);
	end
});

cache.register({
	name="raiding",
	set=function(varid,ent,cached)
		cached[varid]=readbool();
	end
});