if SERVER then util.AddNetworkString( "rw.pmsg" ) end

function pmsg( Ent, Args )

    if #Args % 2 != 0 then return end

    if SERVER then
        if !Ent then Ent = player.GetAll() end

        net.Start( "rw.pmsg" )
            net.WriteInt( #Args, 8 )
            for i = 1, #Args, 2 do
                if !Args[i] || Args[i] == "" then Args[i] = "white" end
                net.WriteString( Args[i] )
                net.WriteString( Args[ i + 1 ] )
            end
        net.Send( Ent || player.GetAll() )
    end

    if CLIENT then
        pdeliver( Args )
    end

end

function pnetdeliver()

    if SERVER then return end
    local ptbl = {}

    local len = net.ReadInt( 8 )
    for i = 1, len, 2 do
        ptbl[ i ] = net.ReadString()
        ptbl[ i ] = color.get( ptbl[ i ] ) || color.get( "whitest" )
        ptbl[ i + 1 ] = net.ReadString()
    end

    chat.AddText( unpack( ptbl ) )

end

function pdeliver( Args )

    if SERVER then return end
    local ptbl = {}

    local len = #Args
    for i = 1, len, 2 do
        if !Args[i] || Args[i] == "" then Args[i] = "whitest" end
        ptbl[ i ] = Args[ i ]
        ptbl[ i ] = color.get( Args[ i ] ) || color.get( "whitest" )
        ptbl[ i + 1 ] = Args[ i + 1 ]
    end

    chat.AddText( unpack( ptbl ) )

end

if CLIENT then net.Receive( "rw.pmsg", pnetdeliver ) end