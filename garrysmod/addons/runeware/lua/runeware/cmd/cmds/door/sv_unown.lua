if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "unown";
CMD.usage       = "unown";
CMD.description = "Sell the property you're looking at.";
CMD.power       = role.member;
function CMD.run(pl,args,argstr)
	local e=pl:GetEyeTrace().Entity;
	local entidx=e:EntIndex();
	pl:unowndoor(entidx);
end
cmd.add(CMD);