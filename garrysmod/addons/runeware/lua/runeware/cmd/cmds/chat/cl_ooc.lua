if !cmd.enabled then return; end

net.Receive("chat.ooc",function()
	local ply = Player(net.ReadUInt( 7 ))
    local argstr = net.ReadString()
	chat.AddText(color.get("green"),"[OOC] " ,ply:getjob().color, ply:GetName(), Color(255,255,255),": " ,Color(255,255,255),argstr );
end);