if !rwchat.enabled then return; end
local netstr=util.AddNetworkString;
netstr("chat.udpchat");
local function loop( t, start, End )
    for i = start, End do
        local v = t[i]
        if !v then return end

        if IsColor(v) then
            net.WriteUInt(chat.enums.color, tobits(chat.enums.count))
            net.WriteUInt(v.r, 8)
            net.WriteUInt(v.g, 8)
            net.WriteUInt(v.b, 8)
        else 
            net.WriteUInt(chat.enums.string, tobits(chat.enums.count))
            net.WriteString(tostring(v)) 
        end
    end
end

function rwchat.AddText(...)
    local args = {...}
    local plys = args[1] 
    if (!IsColor(args[1])) and (IsValid(args[1]) and args[1]:IsPlayer()) or (istable(args[1])) then
        net.Start("chat.udpchat")
        loop(args, 2, #args)
        net.Send(plys)
    else
        net.Start("chat.udpchat")
        loop(args, 1, #args)
        net.Broadcast()
    end
end
-- rwchat.AddText(player.GetAll(), Color(0, 0, 255), "Te", Color(0, 255, 0), "st")