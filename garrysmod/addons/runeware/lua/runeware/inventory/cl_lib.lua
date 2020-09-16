if !inventory.enabled then return; end
local readuint=net.ReadUInt;
local clamp=math.Clamp;
cache.register({
	name="inventory",
	init=function(varid,ent,cached)
		cached[varid]={};
		cached[varid][1]={item["backpack"]};		
	end,
	add=function(varid,ent,cached)
		local data=
		{
			readuint(3),
			readuint(5),
			readuint(8),
			readuint(8),
			readuint(7),
			readuint(7),
		};
		if !cached[varid][data[1]] then cached[varid][data[1]]={data[3]}; end
		cached[varid][data[1]][data[2]]={data[4],data[5],data[6]};
	end,
	remove=function(varid,ent,cached)
		local data={readuint(3),readuint(5)};
		cached[varid][data[1]][data[2]]=nil;
	end,
	removen=function(varid,ent,cached)
		local data={readuint(3),readuint(5),readuint(7)};
		local old=cached[varid][data[1]][data[2]][2];
		cached[varid][data[1]][data[2]][2]=clamp(old-data[3],0,127);
	end
});