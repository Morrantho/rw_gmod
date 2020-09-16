if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "db";
CMD.usage       = "db";
CMD.description = "Force database reconnect.";
CMD.power       = role.developer;
function CMD.run(pl,args,argstr)
	db.connect();
	db.getplayer({"CONSOLE"},{ents.GetByIndex(0)},db.ongetconsole);
end
cmd.add(CMD);