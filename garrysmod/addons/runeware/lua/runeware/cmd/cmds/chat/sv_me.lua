if !cmd.enabled then return; end
util.AddNetworkString("chat.me")

local CMD         = {};
CMD.name          = "me";
CMD.usage         = "me <message>";
CMD.description   = "Do in action.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    local trgs = ents.FindInSphere( ply:GetPos(), 550 )
    net.Start("chat.me")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Send(trgs)

end
cmd.add(CMD);