if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "addperk";
CMD.usage       = "addperk <perkname>";
CMD.description = "Add a perk.";
CMD.power       = role.member;
function CMD.run(pl,args,argstr)
	if #args < 1 then
		cmd.help(CMD,pl);
		return;
	end
	local perkid = perk[args[1]];
	if !perkid then
		cmd.help(CMD,pl,"Invalid Perk: "..args[1]);
		return;
	end
	perk.add(pl,args[1]);
end
cmd.add(CMD);