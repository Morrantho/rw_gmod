if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "unwant";
CMD.usage       = "unwant <player>";
CMD.description = "Unwant a player.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	
end
cmd.add(CMD);