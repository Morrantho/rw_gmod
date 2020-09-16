if !rwchat.enabled then return; end
local dbg = true 
local function dbgp(str)
    if dbg then 
        print(str)
    end
end

local function receiver(len, ply)
    dbgp("Chat message recieved "..len)
    local args = {} 
    local i = 0
    while len > 0 do --UDP shit
        dbgp(chat.enums.count)
        local msglen = tobits(chat.enums.count)
        local type = net.ReadUInt(msglen)
        if type == chat.enums.color then
            local col = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
            args[#args + 1] = col
            msglen = msglen + 24
            dbgp("Color")
            dbgp(col.r.." "..col.g.." "..col.b)
        elseif type == chat.enums.string then 
            local str = net.ReadString()
            args[#args + 1] = str
            msglen = msglen + #str 
            dbgp("String")
            dbgp(str)
        else
            dbgp("Unknown: "..type)
        end
        len = len - msglen
        i = i + 1
        --100 args is kind of fucked so, if we hit that many then yikes
        if i > 100 then
            MsgC(Color(255,0,0), "Infinite loop in chat.AddText ("..len.."), this is bad, tell a dev. ~Snivy")
            break 
        end
    end

    chat.AddText(unpack(args))
end

net.Receive("chat.udpchat", receiver)