if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "citizen";
CMD.usage       = "citizen";
CMD.description = "Become a citizen.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	if pl:iscitizen() then
		cmd.help(CMD,pl,"You're already a citizen.");
		return;
	end
	pl:setjob("citizen");
end
cmd.add(CMD);