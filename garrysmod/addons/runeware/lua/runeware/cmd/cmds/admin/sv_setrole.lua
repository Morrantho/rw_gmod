if !cmd.enabled then return; end

local match         = string.match;
local hookadd       = hook.Add;
local setrole       = {};
setrole.name        = "setrole";
setrole.usage       = "setrole <steamid> <role>";
setrole.description = "Set a player's role";
setrole.power       = role.headadmin;
setrole.re          = "steam_%d:%d:%d";

function setrole.run(_admin,args,argstr)
	if #args < 2 then
		cmd.help(setrole,_admin);
		return;
	end
	local sid  = args[1]:lower();
	if !match(sid,setrole.re) then
		cmd.help(setrole,_admin,"Invalid SteamID: "..sid);
		return;
	end
	local rolename = args[2]:lower();
	local roleid   = role[rolename];
	if !roleid then
		cmd.help(setrole,_admin,"Invalid Role: "..rolename);
		return;
	end
	if roleid == role.banned then
		cmd.help(setrole,_admin,"You cannot set someone's role to banned.");
		return;
	end
	if IsValid(_admin) && _admin:SteamID() == sid then
		cmd.help(setrole,_admin,"You cannot target yourself.");
		return;
	end
	local tgt = findplayer(sid);
	if !IsValid(tgt) then tgt = sid; end
	role.set(tgt,_admin,rolename);
end

function setrole.ongetplayer(sid,_admin,rolename,exists)
	if !exists then
		cmd.help(setrole,_admin,"Invalid Player: "..sid);
	end
end
hookadd("role.ongetplayer","setrole.ongetplayer",setrole.ongetplayer);

function setrole.onset(data,_admin,rolename)
	local sid  = data.id;
	local name = data.name;
	local adminsid = nil;
	local adminname = nil;
	if !IsValid(_admin) then 
		adminsid  = "STEAM_0:0:18578874";
		adminname = "Console";
	else
		adminsid = _admin:SteamID();
		adminname = _admin:getname();
	end
	success(adminname.." ("..adminsid..") set "..name.." ("..sid..")'s role to "..rolename..".");
end
hookadd("role.onset","setrole.onset",setrole.onset);
cmd.add(setrole);