if !cmd.enabled then return; end

local CMD         = {};
CMD.name          = "waypoint";
CMD.usage         = "waypoint <title>";
CMD.description   = "Set a waypoint.";
CMD.power         = role.member;

function CMD.run(ply,args)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    cache.write("waypoints","add",ply,{
        title=args[1],
        pos=ply:GetPos()
    });
end
cmd.add(CMD);