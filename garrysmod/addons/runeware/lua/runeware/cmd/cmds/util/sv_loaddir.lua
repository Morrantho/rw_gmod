if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "loaddir";
CMD.usage       = "loaddir <dir>";
CMD.description = "Load all lua files in a directory recursively.";
CMD.power       = role.developer;
function CMD.run(pl,args,dir)
	if #args < 1 || dir == "" then
		cmd.help(CMD,pl);
		return;
	end
	sendlua(dir);
	loadshlib(dir);
	loadlib(dir);
	loadsrc(dir);
end
cmd.add(CMD);