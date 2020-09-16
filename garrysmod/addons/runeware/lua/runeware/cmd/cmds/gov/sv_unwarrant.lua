if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "unwarrant";
CMD.usage       = "unwarrant <player>";
CMD.description = "Unwarrant a player.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	
end
cmd.add(CMD);