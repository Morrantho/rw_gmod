if !status.enabled then return; end
local STATUS       = {};
STATUS.name        = "warranted";
STATUS.description = "You have a warrant for your arrest.";
STATUS.procs       = 0;
STATUS.duration    = 240;
STATUS.img         = "";
STATUS.modifier    = 0;
STATUS.maxstacks   = 1;
STATUS.on=function(pl,stacks)

end
STATUS.off=function(pl,stacks)
end
status.add(STATUS);