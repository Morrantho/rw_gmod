if !cmd.enabled then return; end
util.AddNetworkString("chat.warn")

local CMD         = {};
CMD.name          = "warn";
CMD.usage         = "warn <steamid / name>";
CMD.description   = "Warn a player.";
CMD.power         = role.member;

function CMD.run(ply,args)
    if #args > 1 then 
        err( "You can only warn one player at a time", ply )
        return
    end
    if #args < 1 || args[1] == "" then 
        local trg = ply:GetEyeTrace().Entity
        if !trg:IsPlayer() then
            cmd.help(CMD,ply) 
            return
        end
        if trg:GetPos():DistToSqr(ply:GetPos()) > 550^2 then
            err( "This player is too far to be warned", ply )
            return
        end
        local trgs = ents.FindInSphere( ply:GetPos(), 550 )
        net.Start("chat.warn")
            net.WriteUInt(ply:UserID(), 7)
            net.WriteUInt(trg:UserID(), 7)
        net.Send(trgs) 
        return
    else
        local trg = findplayer(args[1])
        if !trg then
            err( "This player is not online or does not exist", ply )
            return
        end
        if trg:GetPos():DistToSqr(ply:GetPos()) > 550^2 then
            err( "This player is too far to be warned", ply )
            return
        end
        local trgs = ents.FindInSphere( ply:GetPos(), 550 )
        net.Start("chat.warn")
            net.WriteUInt(ply:UserID(), 7)
            net.WriteUInt(trg:UserID(), 7)
        net.Send(trgs)
    end
end
cmd.add(CMD,"warning");