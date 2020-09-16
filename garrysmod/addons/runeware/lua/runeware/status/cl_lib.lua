if !status.enabled then return; end
cache.register({
	name="status",
	add=function(netvarid,ent,cached)
		if !cached[netvarid] then cached[netvarid] = {}; end
		local statusid = net.ReadUInt(status.bits);
		local stacks   = net.ReadUInt(5);
		cached[netvarid][statusid] = stacks;
		local STATUS = status[statusid];
		if !STATUS then return; end
		ent:addstatus(STATUS.name);		
	end,
	remove=function(netvarid,ent,cached)
		local statusid = net.ReadUInt(status.bits);
		cached[netvarid][statusid] = nil;
		local STATUS = status[statusid];
		if !STATUS then return; end
		ent:removestatus(STATUS.name);		
	end
});