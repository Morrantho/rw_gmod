if !status.enabled then return; end
local STATUS       = {};
STATUS.name        = "graced";
STATUS.description = "You've been graced with invulnerability.";
STATUS.procs       = 0;
STATUS.duration    = 5;
STATUS.img         = "";
STATUS.modifier    = 0;
STATUS.maxstacks   = 1;
STATUS.on=function(pl,stacks)
	if SERVER then
		pl:SetColor(color.get("white"));
		pl:SetRenderMode(RENDERMODE_TRANSCOLOR);
	elseif CLIENT then
		pl:addfx("graced");
	end
end
STATUS.off=function(pl,stacks)
	if SERVER then
		pl:SetColor(color.get("whitest"));
		pl:SetRenderMode(RENDERMODE_NORMAL);
	elseif CLIENT then
		pl:removefx("graced");
	end
end
status.add(STATUS);