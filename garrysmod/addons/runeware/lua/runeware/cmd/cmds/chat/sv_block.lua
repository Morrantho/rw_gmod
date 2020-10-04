if !cmd.enabled then return; end
util.AddNetworkString("chat.block")

local CMD         = {};
CMD.name          = "block";
CMD.usage         = "block <steamid / name> <message>";
CMD.description   = "Blocks a player from messaging you.";
CMD.power         = role.member;

function CMD.run(ply,args)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    local tgt = findplayer(args[1])
    if !tgt then
        err( "This player is not online or does not exist", ply )
        return
    end
    if tgt == ply then
        err( "You can't block yourself...", ply )
        return
    end
    success( tgt:GetName() .. "(" .. tgt:SteamID() .. ") has been blocked.", ply) 
    
end
cmd.add(CMD);