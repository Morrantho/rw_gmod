if !cmd.enabled then return; end
local match     = string.match;
local CMD       = {};
CMD.name        = "removestatus";
CMD.usage       = "removestatus <player> <status>";
CMD.description = "Remove a status effect from a player.";
CMD.power       = role.developer;

function CMD.run(pl,args,argstr)
	if #args < 2 then
		cmd.help(CMD,pl);
		return;
	end
	local tgtid = table.remove(args,1);
	local tgt = findplayer(tgtid);
	if !IsValid(tgt) then
		cmd.help(CMD,pl,"Invalid Player: "..tgtid);
		return;
	end
	local statusname = table.concat(args," "):lower();
	local statusid   = status[statusname];
	if !statusid then
		cmd.help(CMD,pl,"Invalid Status: "..statusname);
		return;
	end
	local stacks = tgt:getstatus(statusname) || 1;
	tgt:removestatus(statusname);
	success(pl:getname().." removed the status "..statusname.." ".."from "..tgt:getname()..".");
end

cmd.add(CMD);