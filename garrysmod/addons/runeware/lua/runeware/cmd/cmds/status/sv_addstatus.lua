if !cmd.enabled then return; end
local match     = string.match;
local CMD       = {};
CMD.name        = "addstatus";
CMD.usage       = "addstatus <player> <status>";
CMD.description = "Add a status effect to a player.";
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
	tgt:addstatus(statusname);
	success(pl:getname().." added the status "..statusname.." "..stacks.."x to "..tgt:getname()..".");
end

cmd.add(CMD);