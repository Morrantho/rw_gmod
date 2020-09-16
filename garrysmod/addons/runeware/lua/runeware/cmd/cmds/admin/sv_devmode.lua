if !cmd.enabled then return; end
local band=bit.band;
local bor=bit.bor;
local bxor=bit.bxor;
local DM=admin.DEVMODE;
local CMD = {}
CMD.name = "devmode"
CMD.usage = "devmode"
CMD.description = "Enables/disables developer mode."
CMD.power = role.developer

function CMD.run(ply,args,argstr)
	local mode=ply:getusermode();
	local status=choose(band(mode,DM),"enabled","disabled");
	mode=choose(band(mode,DM),bor(mode,DM),bxor(mode,DM));
	ply:setusermode(mode);
	success(ply:getname().." has "..status.." dev mode.");
end
cmd.add(CMD,"dm","developermode");