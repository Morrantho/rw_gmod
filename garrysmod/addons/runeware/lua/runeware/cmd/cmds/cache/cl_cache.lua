if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "cl_cache";
CMD.usage       = "cl_cache, cl_cache <cacheid>, cl_cache <cacheid> <key/idx>";
CMD.description = "Lookup cached data";
CMD.power       = role.member;
function CMD.run(pl,args,argstr)
	if #argstr == 0 then
		logtable(cache.data);
		return;
	end
	local cacheid = args[1];
	local data    = cache.data[cacheid];
	if !data then
		cmd.help(CMD,pl,"No data exists for entity: "..cacheid);
		return;
	end
	if #args > 1 then
		local netvarid = cache.netvars[args[2]] || tonumber(args[2]);
		local value    = data[netvarid];
		if !value then
			cmd.help(CMD,pl,"Non existant key: "..args[2].." for entity: "..cacheid);
			return;
		end
		if type(value) == "table" then
			logtable(value);
		else
			print(value);
		end
	else
		logtable(data);
	end
end
cmd.add(CMD);