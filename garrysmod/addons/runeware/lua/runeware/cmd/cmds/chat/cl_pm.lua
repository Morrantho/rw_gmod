if !cmd.enabled then return; end

net.Receive("chat.pm",function()
	local ply = Player(net.ReadUInt( 7 ))
	local tgt = Player(net.ReadUInt( 7 ))
	local msg = net.ReadString()

	chat.AddText( Color(255,255,0),"[PM] " ,Color(255,200,0), ply:GetName(), Color(255,255,255)," > " ,Color(255,200,0), tgt:GetName() .. ": " ,Color(255,255,255),msg );
end);