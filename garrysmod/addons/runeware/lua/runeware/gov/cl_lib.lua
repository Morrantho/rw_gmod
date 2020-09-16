if !gov.enabled then return; end
local readstr=net.ReadString;

cache.register({
	name="laws",
	set=function(varid,ent,cached)	
		-- cached[varid]=readstr();
	end,
});