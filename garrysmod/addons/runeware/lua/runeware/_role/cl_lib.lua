if !role.enabled then return; end
local readuint=net.ReadUInt;
cache.register({
	name="role",
	set=function(varid,ent,cached)
		cached[varid]=readuint(role.bits);
	end
});