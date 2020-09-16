if !cmd.enabled then return; end

local CMD = {}
CMD.name = "kick"
CMD.usage = "kick < SteamID / ID >"
CMD.description = "Kicks a player from the server."
CMD.power = role.moderator

function CMD.run(pl,args,argstr)
    if #args < 1 or args[1] == "" then cmd.help(CMD,pl) return; end
    local tgt = findplayer(args[1]);
    if !tgt then 
    	err("The player "..args[1].." is not online.",pl);
    	return;
    end
    if tgt == pl then err("You can not target yourself.",pl) return; end
    local reason = argstr:sub(#args[1]+2);
    if reason == "" then reason = "No reason Specified."; end
    success(pl:getname().." kicked "..target:getname()..".");
    target:Kick(reason);
end
cmd.add(CMD);