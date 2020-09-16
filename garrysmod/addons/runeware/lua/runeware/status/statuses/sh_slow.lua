if !status.enabled then return; end
local STATUS       = {};
STATUS.name        = "slowed";
STATUS.description = "You have been slowed.";
STATUS.procs       = 0;
STATUS.duration    = 10;
STATUS.img         = "";
STATUS.modifier    = 50;
STATUS.maxstacks   = 5;
STATUS.on = function(pl,stacks)
	if SERVER then
		if !pl.oldspd then pl.oldspd = pl:GetRunSpeed(); end
		pl:SetRunSpeed(pl.oldspd-(stacks*STATUS.modifier));
	end
end
STATUS.off = function(pl,stacks)
	if SERVER then
		if pl.oldspd then
			pl:SetRunSpeed(pl.oldspd);
			pl.oldspd = nil;
		end
	end
end
status.add(STATUS);