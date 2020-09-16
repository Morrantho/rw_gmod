if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "cop";
CMD.usage       = "cop";
CMD.description = "Become a cop.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	if pl:iscop() then
		cmd.help(CMD,pl,"You are already a cop.");
		return;
	end
	pl:setjob("cop");
end
cmd.add(CMD);