if !cmd.enabled then return; end

net.Receive("chat.whisper",function()
	local ply = Player(net.ReadUInt( 7 ))
	local msg = net.ReadString()

	chat.AddText( Color(200,200,200),"[Whisper] " ,ply:getjob().color, ply:GetName(), Color(255,255,255),": " .. msg );
end);