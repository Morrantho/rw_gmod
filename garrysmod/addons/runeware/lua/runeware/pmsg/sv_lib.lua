util.AddNetworkString( "rw.pmsg" )
function pmsg( Ent, Args )

    if #Args % 2 != 0 then return end
    if !Ent then Ent = player.GetAll() end

    PrintTable( Args )

    net.Start( "rw.pmsg" )
        net.WriteInt( #Args, 8 )
        for i = 1, #Args, 2 do
            if !Args[i] || Args[i] == "" then Args[i] = "white" end
            net.WriteString( Args[i] )
            net.WriteString( Args[ i + 1 ] )
        end
    net.Send( Ent || player.GetAll() )

end