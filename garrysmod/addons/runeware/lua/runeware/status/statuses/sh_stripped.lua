if !status.enabled then return; end
local STATUS       = {};
STATUS.name        = "stripped";
STATUS.description = "Your inventory and items are stripped.";
STATUS.procs       = 0;
STATUS.duration    = 10;
STATUS.img         = "";
STATUS.modifier    = 0;
STATUS.maxstacks   = 1;
STATUS.on = function(pl,stacks)
	if SERVER then
		pl.oldweps = {};
		for a,b in pairs(pl:GetWeapons()) do
			pl.oldweps[#pl.oldweps+1] = b:GetClass();
		end
		pl:StripWeapons();
	end
end
STATUS.off = function(pl,stacks)
	if SERVER then
		if !pl.oldweps then return; end
		for i=1,#pl.oldweps do
			pl:Give(pl.oldweps[i]);
		end
		pl.oldweps = nil;
	end
end
status.add(STATUS);