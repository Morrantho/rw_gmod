if !cmd.enabled then return; end
local floor     = math.floor;
local abs       = math.abs;

local CMD       = {};
CMD.name        = "unban";
CMD.usage       = "unban <sid>";
CMD.description = "Unban a player.";
CMD.re          = "steam_%d:%d:%d";
CMD.power       = role.headadmin;

function CMD.run(_admin,args,argstr)
	if #args < 1 then
		cmd.help(CMD,_admin);
		return;
	end
	local sid = table.remove(args,1);
	if !sid:lower():match(CMD.re) then
		cmd.help(CMD,_admin,"Invalid SteamID: "..sid..".");
		return;
	end
	ban.unbanplayer(_admin,sid);
end
cmd.add(CMD);