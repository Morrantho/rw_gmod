if !cmd.enabled then return; end
util.AddNetworkString("chat.global")

local CMD         = {};
CMD.name          = "global";
CMD.usage         = "global";
CMD.description   = "Send a message to everyone.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    net.Start("chat.global")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Broadcast() 
end
cmd.add(CMD,"advert","ad");