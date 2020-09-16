if !cmd.enabled then return; end
local CMD={};
CMD.name="restart";
CMD.usage="restart";
CMD.description="RestartServer";
CMD.power=role.developer;
function CMD.run(pl,args,dir)
	RunConsoleCommand("changelevel","rp_c18_divrp_v5");
end
cmd.add(CMD);