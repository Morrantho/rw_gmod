if !cmd.enabled then return; end
util.AddNetworkString("chat.adminreply")

local CMD         = {};
CMD.name          = "adminreply";
CMD.usage         = "adminreply <user> <message>";
CMD.description   = "Reply to a member via staff chat.";
CMD.power         = role.moderator;

function CMD.run(ply,args,argstr)
    if #args < 2 || args[1] == "" then cmd.help(CMD,ply); return; end
    local trg = findplayer(args[1])
    local trgs = role.getplayers(role.moderator)
    if !trg || !trgs then cmd.help(CMD,ply) return end
    local msg = argstr:sub(#args[1]+2)
    table.insert( trgs,#trgs+1, trg)
    net.Start("chat.adminreply")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteUInt(trg:UserID(), 7)
        net.WriteString(msg)
    net.Send(trgs)
end
cmd.add(CMD,"ar","r");