if !cmd.enabled then return; end
local popf=table.remove;
local cat=table.concat;
local CMD={};
CMD.name="setlaws";
CMD.usage="setlaws <new_laws>";
CMD.description="Set the laws of the city.";
CMD.power=role.member;

function CMD.run(pl,args,argstr)
	if #args<1||argstr=="" then
		cmd.help(CMD,pl);
		return;
	end
	gov.setlaws(pl,argstr);
end
cmd.add(CMD);