if !rwplayer.enabled then return; end
local readuint=net.ReadUInt;
local readstr=net.ReadString;
local readbool=net.ReadBool;
local hookadd = hook.Add;
local tse = timer.Simple;

function rwplayer.initpostentity()
	tse( 0.1, function()
		net.Start( "rwplayer.onclientinit" )
		net.SendToServer()
	end)
end
hookadd("InitPostEntity","rwplayer.initpostentity",rwplayer.initpostentity);

function rwplayer.uisound()
	local sndstr = net.ReadString()
	if !sndstr || sndstr == "" || !file.Exists( "sound/" .. sndstr, "GAME") then return end
	surface.PlaySound( sndstr )
end
net.Receive("rwplayer.uisound", rwplayer.uisound)

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