if !status.enabled then return; end
cache.register({
	name="status",
	add=function(varid,ent,cached,netdata)
		local statusid = netdata[1];
		local stacks   = netdata[2];
		if !cached[varid] then cached[varid] = {}; end
		cached[varid][statusid] = stacks;
		net.WriteUInt(statusid,status.bits);
		net.WriteUInt(stacks,5); -- 0-31
	end,
	remove=function(varid,ent,cached,netdata)
		local statusid = netdata[1];
		cached[varid][statusid] = nil;
		net.WriteUInt(statusid,status.bits);
	end
});