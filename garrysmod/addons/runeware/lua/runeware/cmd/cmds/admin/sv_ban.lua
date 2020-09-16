if !cmd.enabled then return; end
local floor     = math.floor;
local abs       = math.abs;
local CMD       = {};
CMD.name        = "ban";
CMD.usage       = "ban <sid> <duration> <timeunit> <reason>";
CMD.description = "Ban a player.";
CMD.re          = "steam_%d:%d:%d";
CMD.power       = role.moderator;

function CMD.run(_admin,args,argstr)
	if #args < 3 then
		cmd.help(CMD,_admin);
		return;
	end
	local sid = table.remove(args,1);
	if !sid:lower():match(CMD.re) then
		cmd.help(CMD,_admin,"Invalid SteamID: "..sid..".");
		return;
	end
	local duration = abs(floor(tonumber(table.remove(args,1))));
	if !duration then
		cmd.help(CMD,_admin,"Duration must be a number.");
		return;
	end
	local unit = table.remove(args,1);
	if admin.banaliases[unit] then
		unit = admin.banaliases[unit];
	end
	local minpower   = admin.banunits[unit];
	if !minpower then
		cmd.help(CMD,_admin,"Invalid Timeunit: "..unit..".");
		return;
	end
	local adminpower = _admin:getpower();
	if adminpower < minpower then
		cmd.help(CMD,_admin,"You don't have the power to ban using this unit of measurement.");
		return;
	end
	local bantimes = admin.bantimes[adminpower];
	if bantimes then
		local maxtime = bantimes[unit];
		local rolename = role[adminpower];
		if duration > maxtime then
			cmd.help(CMD,_admin,rolename.."s can only ban for "..maxtime.." "..unit.."(s) maximum.");
			return;
		end
	end
	local reason = table.concat(args," ") || "No reason specified.";
	ban.banplayer(_admin,sid:upper(),duration,unit,reason);
end

cmd.add(CMD);