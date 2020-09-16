if !status.enabled then return; end
local STATUS={};
STATUS.name="wanted";
STATUS.description="You are a wanted criminal.";
STATUS.procs=0;
STATUS.duration=120;
STATUS.img="";
STATUS.modifier=0;
STATUS.maxstacks=1;
STATUS.on=function(pl,stacks)

end
STATUS.off=function(pl,stacks)
end
status.add(STATUS);