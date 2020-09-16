if !cmd.enabled then return; end
local band=bit.band;
local bor=bit.bor;
local bxor=bit.bxor;
local AM=admin.ADMINMODE;
local choose=choose;
local CMD={};
CMD.name="adminmode";
CMD.usage="adminmode";
CMD.description="Enables/disables adminmode";
CMD.power=role.moderator;
CMD.nocheck=true;
function CMD.run(ply,args,argstr)
	local mode=ply:getusermode();
	local status=choose(band(mode,AM),"enabled","disabled");
	mode=choose(band(mode,AM),bor(mode,AM),bxor(mode,AM));
	ply:setusermode(mode);
	success(ply:getname().." has "..status.." admin mode.");
end
cmd.add(CMD,"am","admin");