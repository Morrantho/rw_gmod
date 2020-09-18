local writestr=net.WriteString;
local writevec=net.WriteVector;

cache.register({
	name="waypoints",
	
	add=function(varid,ent,cached,netdata)
		if !cached[varid] then cached[varid]={}; end
		cached[varid][netdata.title]=netdata.pos;
		writestr(netdata.title);
		writevec(netdata.pos);
	end,

	remove=function(varid,ent,cached,netdata)
		cached[varid][netdata.title]=nil;
		writestr(netdata.title);
	end
});