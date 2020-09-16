if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "clear";
CMD.usage       = "clear";
CMD.description = "Clear server console.";
CMD.power       = role.developer;
function CMD.run(pl,args,argstr)
	for i=1,100 do print(""); end
end
cmd.add(CMD);