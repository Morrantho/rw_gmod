local events = {}
events.enabled = events.enabled || true
if !events.enabled then return end
local hookadd = hook.Add

events.roomvector = Vector( -3475, -6628, 1288 )
events.roomangle = Angle( 0, 90, 90 )
events.buttontable =
{
    [1] =
    {
        ["Text"] = "Lower Water",
        ["Vec"] = Vector( -3640, -6741, 1274 )
    },
    [2] =
    {
        ["Text"] = "Raise Water",
        ["Vec"] = Vector( -3640, -6715, 1274 )
    },
    [3] =
    {
        ["Text"] = "Lower Lights",
        ["Vec"] = Vector( -3640, -6636, 1274 )
    },
    [4] =
    {
        ["Text"] = "Raise Lights",
        ["Vec"] = Vector( -3640, -6611, 1274 )
    },
    [5] =
    {
        ["Text"] = "Close Roof",
        ["Vec"] = Vector( -3640, -6533, 1274 )
    },
    [6] =
    {
        ["Text"] = "Open Roof",
        ["Vec"] = Vector( -3640, -6507, 1274 )
    }
}

function events.buttonrender()

    if LocalPlayer():withinvector( events.roomvector, 400 ) then
        for i = 1, #events.buttontable do
            cam.Start3D2D( events.buttontable[i]["Vec"], events.roomangle, .125 )
                draw.SimpleTextOutlined( events.buttontable[i]["Text"], "rwtitle36", 0, 0, color.get( "green" ), 1, 1, 1, color.get( "black" ) )
            cam.End3D2D()
        end
    end

end
hookadd( "PostDrawTranslucentRenderables", "events.buttonrender", events.buttonrender )