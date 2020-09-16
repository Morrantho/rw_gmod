if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "own";
CMD.usage       = "own";
CMD.description = "Purchase the property you're looking at.";
CMD.power       = role.member;
function CMD.run(pl,args,argstr)
	local e=pl:GetEyeTrace().Entity;
	local entidx=e:EntIndex();
	local dist=pl:GetPos():DistToSqr(e:GetPos());
	if dist>10000 then
		err("You are too far away to purchase this property.",pl);
		return;
	end
	pl:owndoor(entidx);
end
cmd.add(CMD);