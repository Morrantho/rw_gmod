if !cmd.enabled then return; end
local popf=table.remove;
local cat=table.concat;
local CMD       = {};
CMD.name        = "want";
CMD.usage       = "want <player> <reason>";
CMD.description = "Want a player.";
CMD.power       = role.member;

function CMD.run(cop,args,argstr)
	local name=popf(args,1);
	local tgt=findplayer(name);
	if !tgt then
		cmd.help(CMD,cop,"Invalid Player: "..name);
		return;
	end
	local rsn=cat(args," ");
	tgt:want(cop,rsn);
end
cmd.add(CMD);