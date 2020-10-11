if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "tele";
CMD.usage       = "teleport <steamid / name>";
CMD.description = "Teleports the specified player to your crosshair.";
CMD.power       = role.admin;

function CMD.run(pl,args,argstr)
	if #args < 1 || args[1] == "" then cmd.help(CMD,pl); return; end
	local tgt = findplayer(args[1]);
	if !tgt then err("The player "..args[1].." does not exist.",pl) return end
	if tgt == pl then err("You can not target yourself.",pl); return; end
	if !tgt:Alive() then tgt:Spawn(); end
	tgt:SetPos(pl:GetEyeTrace().HitPos);
	tgt:EmitSound("garrysmod/balloon_pop_cute.wav");
	success(pl:getname().." has teleported "..tgt:getname()..".");
end
cmd.add(CMD);