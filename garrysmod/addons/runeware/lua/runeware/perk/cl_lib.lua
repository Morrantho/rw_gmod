if !perk.enabled then return; end
local readuint=net.ReadUInt;

cache.register({
	name="perks",
	add=function(varid,ent,cached)
		local data = {readuint(8),readuint(3)}; -- perkid, tier
		if !cached[varid] then cached[varid] = {}; end -- init perks table
		cached[varid][data[1]] = data[2];
	end
});

cache.register({
	name="perkpoints",
	set=function(varid,ent,cached)
		cached[varid] = readuint(8);
	end
});