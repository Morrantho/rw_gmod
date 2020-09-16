if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "cl_netvar";
CMD.usage       = "cl_netvar";
CMD.description = "Resolves netvar ids to their names";
CMD.power       = role.developer;
function CMD.run(pl,args,argstr)
	for a,b in pairs(cache.netvars) do
		if type(b) == "table" then continue; end
		print("netvar:",a,b);
	end
end
cmd.add(CMD);