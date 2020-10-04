if !cmd.enabled then return; end

net.Receive("chat.yell",function()
	local ply = Player(net.ReadUInt( 7 ))
	local msg = net.ReadString()

	chat.AddText( Color(200,0,0),"[YELL] " ,ply:getjob().color, ply:GetName(), Color(255,255,255),": " .. msg );
end);