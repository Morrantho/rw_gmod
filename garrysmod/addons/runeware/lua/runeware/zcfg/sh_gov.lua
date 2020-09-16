if !gov.enabled then return; end
local vec=Vector;
gov.wanttime=120;--karma/perk dependant
gov.warranttime=240;--karma/perk dependant
gov.arresttime=120;--karma dependant
gov.gracetime=300;--perk dependant

gov.jails=
{
	vec(1863,940,432), -- jail1
	vec(1991,937,432), -- jail2
	vec(2113,952,432), -- jail3
	vec(2389,893,432), -- jail4-1
	vec(2388,965,432), -- jail4-2
	vec(2238,982,432), -- jail4-3
	vec(2236,903,432), -- jail4-4
};

gov.unjails=
{
	vec(2737,1358,992),
	vec(2562,1355,992),
	vec(2549,1193,993),
	vec(2740,1191,992),
};