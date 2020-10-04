if !cmd.enabled then return; end
util.AddNetworkString("chat.ooc")

local CMD         = {};
CMD.name          = "ooc";
CMD.usage         = "ooc";
CMD.description   = "Send a message in out of character chat.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    net.Start("chat.ooc")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Broadcast() 
end
cmd.add(CMD,"/");