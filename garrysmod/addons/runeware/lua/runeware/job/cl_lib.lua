if !job.enabled then return; end
local readuint=net.ReadUInt;
local clamp=math.Clamp;
cache.register({
	name="job",
	set=function(varid,ent,cached)
		cached[varid]=readuint(4);
	end
});