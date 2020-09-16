if !cmd.enabled then return; end

local CMD       = {};
CMD.name        = "goto";
CMD.usage       = "goto <steamid / name>";
CMD.description = "Teleports you to the specified player.";
CMD.power       = role.admin;

function CMD.run(ply,args,argstr)
	if #args<1||args[1]=="" then cmd.help(CMD,ply) return; end
	local tgt=findplayer(args[1]);
	if !tgt then
		err("The player "..args[1].." does not exist.",ply);
		return;
	end
	if tgt==ply then err("You can not target yourself.",ply); return; end
	ply:SetPos(tgt:GetPos());
	tgt:EmitSound("garrysmod/balloon_pop_cute.wav");
	success(ply:getname().." has teleported to "..(tgt:getname()||tgt:Name())..".");
end
cmd.add(CMD);