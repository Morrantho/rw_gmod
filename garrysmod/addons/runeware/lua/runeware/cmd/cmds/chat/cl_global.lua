if !cmd.enabled then return; end

net.Receive("chat.global",function()
	local ply = Player(net.ReadUInt( 7 ))
    local argstr = net.ReadString()
	chat.AddText(color.get("redder"),"[GLOBAL] " ,ply:getjob().color, ply:GetName(), Color(255,255,255),": " ,Color(240,230,100),argstr );
end);