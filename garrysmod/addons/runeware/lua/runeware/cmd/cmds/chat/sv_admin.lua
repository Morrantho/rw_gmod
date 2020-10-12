if !cmd.enabled then return; end
util.AddNetworkString("chat.admin")

local CMD         = {};
CMD.name          = "admin";
CMD.usage         = "admin <message>";
CMD.description   = "Send a message to the admins.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end

    local trgs = role.getplayers(role.moderator)
    if !trgs then
        err( "There are no admins online currently, sorry!", ply )
        return
    end
    table.insert( trgs, ply)

    -- if ply:getrole() < 3 then
    --     cache.put(ply,"quickreply",60)
    -- end

    net.Start("chat.admin")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Send(trgs)
end
cmd.add(CMD,"a","staff");