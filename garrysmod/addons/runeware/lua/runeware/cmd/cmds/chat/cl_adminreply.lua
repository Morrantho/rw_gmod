if !cmd.enabled then return; end

net.Receive("chat.adminreply",function()
    local ply = Player(net.ReadUInt( 7 ))
    local trg = Player(net.ReadUInt( 7 ))
    local msg = net.ReadString()
    if ply:getrole() > 2 then
        chat.AddText( color.get("green"),"[STAFF] " ,Color(255,255,255), ply:GetName() .. " >> " .. trg:GetName() .. ": " .. msg );   
    else
        chat.AddText( Color(0, 250, 225),"[FROM STAFF] " ,Color(255,255,255), ply:GetName() .. ": " .. msg );   
        surface.PlaySound( "hl1/fvox/blip.wav" )
    end
end);