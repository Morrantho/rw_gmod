if !cmd.enabled then return; end
util.AddNetworkString("chat.whisper")

local CMD         = {};
CMD.name          = "whisper";
CMD.usage         = "whisper <message>";
CMD.description   = "Whisper to people very close by.";
CMD.power         = role.member;

function CMD.run(ply,args,argstr)
    if #args < 1 || args[1] == "" then cmd.help(CMD,ply); return; end
    local trgs = ents.FindInSphere(ply:GetPos(), 150 )
    net.Start("chat.whisper")
        net.WriteUInt(ply:UserID(), 7)
        net.WriteString(argstr)
    net.Send(trgs)

end
cmd.add(CMD,"w");