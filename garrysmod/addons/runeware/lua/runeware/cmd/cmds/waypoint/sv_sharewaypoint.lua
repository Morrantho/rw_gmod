if !cmd.enabled then return; end
local popf=table.remove;
local cat=table.concat;

local CMD         = {};
CMD.name          = "sharewaypoint";
CMD.usage         = "sharewaypoint <player> <name>";
CMD.description   = "Share a waypoint with another player.";
CMD.power         = role.member;

function CMD.run(ply,args)
	if #args<2 then cmd.help(CMD,ply); return; end
	local tgtname=popf(args,1);
	local tgt=findplayer(tgtname);
	if !IsValid(tgt) then
		cmd.help(CMD,ply,"Invalid Player: "..tgtname);
		return;
	end
	local name=cat(args," ");
	local waypoints=cache.get(ply,"waypoints")||{};
	if !waypoints[name] then
		cmd.help(CMD,ply,"Invalid Waypoint: "..name);
		return;
	end
	local tgtwaypoints=cache.get(tgt,"waypoints")||{};
	if tgtwaypoints[name] then
		cmd.help(CMD,ply,tgt:getname().." already has this waypoint.");
		return;
	end
	cache.write("waypoints","add",tgt,{
		title=name,
		pos=waypoints[name]
	});
	success("You shared the waypoint: "..name.." with "..tgt:getname()..".",ply);
	success(ply:getname().." shared the waypoint "..name.." with you.",tgt);
end
cmd.add(CMD);