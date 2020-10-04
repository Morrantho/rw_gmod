if !cmd.enabled then return; end
util.AddNetworkString("chat.pm")

local CMD         = {};
CMD.name          = "pm";
CMD.usage         = "pm <steamid / name> <message>";
CMD.description   = "Message a plyer.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 2 || args[1] == "" then cmd.help(CMD,ply); return; end
    local tgt = findplayer(args[1])
    local msg = argstr:sub(#args[1]+2)
    if !tgt then
        err( "This player is not online or does not exist", ply )
        return
    end
    if tgt == ply then
        err( "Why are you talking to yourself?", ply )
        return
    end
    net.Start("chat.pm")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteUInt(tgt:UserID(), 7)
        net.WriteString(msg)
    net.Send({ply,tgt}) 
end
cmd.add(CMD);