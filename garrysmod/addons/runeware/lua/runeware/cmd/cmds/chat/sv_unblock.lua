if !cmd.enabled then return; end
util.AddNetworkString("chat.unblock")

local CMD         = {};
CMD.name          = "unblock";
CMD.usage         = "unblock <steamid / name> <message>";
CMD.description   = "Unblock a player you blocked.";
CMD.power         = role.member;

function CMD.run(ply,args)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    local tgt = findplayer(args[1])
    if !tgt then
        err( "This player is not online or does not exist", ply )
        return
    end
    if tgt == ply then
        err( "You cannot unblock yourself.", ply )
        return
    end
    success( tgt:GetName() .. "(" .. tgt:SteamID() .. ") has been unblocked.", ply) 
    
end
cmd.add(CMD);