if !status.enabled then return; end

local STATUS={};
STATUS.name="ghosted";
STATUS.description="You are invulnerable, but cannot interact with most entities.";
STATUS.procs=0;
STATUS.duration=5;
STATUS.img="";
STATUS.modifier=0;
STATUS.maxstacks=1;
STATUS.on=function(pl,stacks)
	if SERVER then
		pl:SetColor(color.get("whitest"));
		pl:SetRenderMode(RENDERMODE_TRANSCOLOR);
	elseif CLIENT then
		pl:addfx("ghosted");
	end
end
STATUS.off=function(pl,stacks)
	if SERVER then
		pl:SetColor(color.get("whitest"));
		pl:SetRenderMode(RENDERMODE_NORMAL);
	elseif CLIENT then
		pl:removefx("ghosted");
	end
end
status.add(STATUS);