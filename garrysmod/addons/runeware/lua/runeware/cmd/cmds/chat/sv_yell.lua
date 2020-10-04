if !cmd.enabled then return; end
util.AddNetworkString("chat.yell")

local CMD         = {};
CMD.name          = "yell";
CMD.usage         = "yell <message>";
CMD.description   = "SCREAM AT THE TOP OF YOUR LUNGS!";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    local trgs = ents.FindInSphere( ply:GetPos(), 550 )
    net.Start("chat.yell")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Send(trgs)

end
cmd.add(CMD,"y");