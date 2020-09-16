if !cache.enabled then return; end
local netrcv=net.Receive;
local readuint=net.ReadUInt;
local getbyidx=ents.GetByIndex;
-- cl lib
function cache.read()
	local netvarid = readuint(8);
	print("cache.read: ","netvarid: ",netvarid);
	local netvar   = cache.netvars[netvarid];
	local funcid   = readuint(netvar.funcbits);
	local func     = netvar[funcid];
	local cacheid  = readuint(13);
	local ent      = getbyidx(cacheid);
	if ent:IsPlayer() then cacheid=ent:SteamID(); end
	if !cache.data[cacheid] then cache.data[cacheid] = {}; end
	if func then func(netvarid,ent,cache.data[cacheid]); end
	if cache.dbg then cache.log(netvarid,funcid,ent); end
end
netrcv("cache.write",cache.read);