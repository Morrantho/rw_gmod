if !status.enabled then return; end
local STATUS       = {};
STATUS.name        = "starving";
STATUS.description = "You are starving! Eat food to negate this!";
STATUS.procs       = 0;
STATUS.duration    = 1;
STATUS.img         = "";
STATUS.modifier    = 0;
STATUS.maxstacks   = 1;
STATUS.on = function(pl,stacks)

end
STATUS.off = function(pl,stacks)

end
STATUS.proc = function(pl,stacks)
	
end
status.add(STATUS);