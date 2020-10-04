if !cmd.enabled then return; end

net.Receive("chat.admin",function()
	local ply = Player(net.ReadUInt( 7 ))
    local argstr = net.ReadString()
    if ply:getrole() > 2 then
        chat.AddText( color.get("green"),"[STAFF] " ,Color(255,255,255), ply:GetName() .. ": " .. argstr );   
    else
        chat.AddText( Color(0, 250, 225),"[TO STAFF] " ,Color(255,255,255), ply:GetName() .. ": " .. argstr );
        surface.PlaySound( "hl1/fvox/blip.wav" )
    end
end);