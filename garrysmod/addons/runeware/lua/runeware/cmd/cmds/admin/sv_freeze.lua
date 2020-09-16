if !cmd.enabled then return; end
local CMD = {}
CMD.name = "freeze"
CMD.usage = "freeze < steamid / name >"
CMD.description = "Freezes a player on the server."
CMD.power = role.admin

function CMD.run(pl,args,argstr)
    if #args < 1 or args[1] == "" then
    	err("You must provide a player name.",pl); 
    	return;
    end
    local tgt = findplayer(args[1]);
    if !tgt then
    	err("The player "..args[1].." is not online.",pl);
    	return;
    end
    tgt:Freeze(!tgt:IsFrozen());
    local status = choose(tgt:IsFrozen(),"frozen","unfrozen");
    success(pl:getname().." has "..status.." "..target:getname()..".");
end
cmd.add(CMD);