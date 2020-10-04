if !cmd.enabled then return; end

net.Receive("chat.warn",function()
    local ply = Player(net.ReadUInt( 7 ))
    local trg = Player(net.ReadUInt( 7 ))

	chat.AddText( Color(230, 69, 25),"[WARN] " ,ply:GetName() .. " warns " .. trg:GetName() .. "." );
end);