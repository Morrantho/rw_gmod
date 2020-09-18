local readstr=net.ReadString;
local readvec=net.ReadVector;
local hookadd=hook.Add;
local localplayer=LocalPlayer;
local camstart=cam.Start3D2D;
local camend=cam.End3D2D;

function waypoint.draw2d()
	local pl=LocalPlayer();
	local plpos=pl:GetPos();
	local waypoints=cache.get("waypoints",pl)||{};
	for title,wpos in pairs(waypoints) do
		-- idk why this code keeps vanishing, but what was here was ancient.
	end
end
hookadd("HUDPaint","waypoint.draw2d",waypoint.draw2d);

function waypoint.draw3d()
	local pl=LocalPlayer();
	local waypoints=cache.get("waypoints",pl)||{};
	for title,wpos in pairs(waypoints) do
		-- idk why this code keeps vanishing, but what was here was ancient.
	end
end
hookadd("PostDrawTranslucentRenderables","waypoint.draw3d",waypoint.draw3d);

cache.register({
	name="waypoints",
	
	add=function(varid,ent,cached,netdata)
		if !cached[varid] then cached[varid]={}; end
		cached[varid][readstr()]=readvec();
	end,

	remove=function(varid,ent,cached,netdata)
		cached[varid][readstr()]=nil
	end
});