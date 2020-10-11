if !cmd.enabled then return; end

net.Receive("chat.me",function()
	local ply = Player(net.ReadUInt( 7 ))
	local msg = net.ReadString()

	chat.AddText( Color(230,230,0), ply:GetName() .. " " .. msg );
end);