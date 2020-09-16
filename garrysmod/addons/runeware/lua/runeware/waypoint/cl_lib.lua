local readstr=net.ReadString;
local readvec=net.ReadVector;
local hookadd=hook.Add;
local localplayer=LocalPlayer;


function waypoint.draw2d()
    print("waypoint.draw2d");
    -- local pl=LocalPlayer();
    -- local plpos=pl:GetPos();
    -- local waypoints=cache.get("waypoints",pl);
    -- for title,wpos in pairs(waypoints) do
        -- local dist=plpos:Dot(wpos)
        -- local triangle = {
        --     { x = 100, y = 200 },
        --     { x = 150, y = 100 },
        --     { x = 200, y = 200 }
        -- }
        -- draw.DrawText
    -- end
end
hookadd("HUDPaint","waypoint.draw2d",waypoint.draw2d);

function waypoint.draw3d()
    print("waypoint.draw3d");
    -- local pl=LocalPlayer();
    -- local waypoints=cache.get("waypoints",pl);
    -- for title,wpos in pairs(waypoints) do
    --     cam.Start3D2D(wpos);
    --         surface.DrawCircle(0,0,64,Color(255,0,0));
    --     cam.End3D2D(); 
    -- end
end
hookadd("PostDrawTranslucentRenderables","waypoint.draw3d",waypoint.draw3d);

-- 32+math.sin(CurTime())*32
cache.register({
    name="waypoints",
    
    add=function(varid,ent,cached,netdata)
        print("WAYPOINT ASS");
        if !cached[varid] then cached[varid]={}; end
        cached[varid][readstr()]=readvec();
    end,

    remove=function(varid,ent,cached,netdata)
        print("WAYPOINT REMOVE");
        cached[varid][readstr()]=nil
    end
});