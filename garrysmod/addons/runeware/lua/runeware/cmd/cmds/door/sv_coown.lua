if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "coown";
CMD.usage       = "coown <steamid/playername>";
CMD.description = "Share a property with another player.";
CMD.power       = role.member;
function CMD.run(pl,args,argstr)
	if #args<1 then
		cmd.help(CMD,pl);
		return;
	end
	local e=pl:GetEyeTrace().Entity;
	local entidx=e:EntIndex();
	local dist=pl:GetPos():DistToSqr(e:GetPos());
	if dist>10000 then
		cmd.help(CMD,pl,"You are too far away to share this property.");
		return;
	end
	local tgt=findplayer(args[1]);
	if !IsValid(tgt) then
		cmd.help(CMD,pl,"Invalid Player: "..args[1]);
		return;
	end
	pl:coowndoor(tgt,entidx);
end
cmd.add(CMD);