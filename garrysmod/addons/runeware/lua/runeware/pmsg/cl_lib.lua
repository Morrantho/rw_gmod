function pdeliver()

    local len = net.ReadInt( 8 )
    local ptbl = {}

    for i = 1, len, 2 do
        ptbl[ i ] = net.ReadString()
        ptbl[ i ] = color.get( ptbl[ i ] ) || color.get( "whitest" )
        ptbl[ i + 1 ] = net.ReadString()
    end

    chat.AddText( unpack( ptbl ) )

end
net.Receive( "rw.pmsg", pdeliver )