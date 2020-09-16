if !cmd.enabled then return; end
local tableremove = table.remove;
local tableconcat = table.concat;

local CMD         = {};
CMD.name          = "demote";
CMD.usage         = "demote <player/sid> <reason>";
CMD.description   = "Demote a player.";
CMD.power         = role.member;

function CMD.run(pl,args,argstr)
	if pl:isconsole() then cmd.help(CMD,pl,"Player only."); return; end
	if #args < 2 then
		cmd.help(CMD,pl);
		return;
	end
	local tgtstr = tableremove(args,1);
	local tgt = findplayer(tgtstr);
	if !tgt then
		err("Invalid Player: "..tgtstr,pl);
		return;
	end
	local rsn = tableconcat(args," ");
	tgt:demote(pl,rsn);
end
cmd.add(CMD);