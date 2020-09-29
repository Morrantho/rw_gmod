cache=cache||{};
cache.dbg=cache.dbg||false;
cache.enabled=cache.enabled||true;
cache.netvars=cache.netvars||{};
cache.data=cache.data||{};
cache.msgs=cache.msgs||{};
cache.dump=cache.dump||{};
if !cache.enabled then return; end
function cache.register(netvar)
	local netvarid=cache.netvars[netvar.name];
	if !netvarid then netvarid=#cache.netvars+1; end
	local funcid=1;
	for a,b in pairs(netvar) do -- map functions to indices
		if type(b)~="function" then continue; end
		netvar[funcid]=b;
		netvar[a]=funcid;
		if cache.dbg then
			print("cache.register: "," funcname: ",a," funcid: ",funcid);
		end
		funcid=funcid+1;
	end
	netvar.funcbits=tobits(funcid);
	cache.netvars[netvarid]=netvar;
	cache.netvars[netvar.name]=netvarid;
	if cache.dbg then
		print("cache.register: ",netvar.name,netvarid);
	end
end

-- only really used for making storage for netvars easier
function cache.put(ent,key,value)
	local cacheid = 0;
	if ent:IsPlayer() then
		cacheid = ent:SteamID();
	else
		cacheid = ent:EntIndex();
	end
	if !cache.data[cacheid] then cache.data[cacheid]={}; end
	local netvarid = cache.netvars[key];
	assert(netvarid,"Invalid Netvar: "..key);
	cache.data[cacheid][netvarid] = value;
end

function cache.get(ent,key)
	local cacheid = 0;
	if ent:IsPlayer() then
		cacheid = ent:SteamID();
	else
		cacheid = ent:EntIndex();
	end
	local data = cache.data[cacheid];
	if !data || !key then return; end
	local netvarid = cache.netvars[key];
	if !netvarid then return; end
	if cache.dbg then
		print("cache.get: ",cacheid, key, netvarid, data[netvarid]);
	end
	return data[netvarid];
end

function cache.log(key,action,ent,value,to)
	if SERVER then
		if type(to) == "table" then
			to = #to;
		else
			to = 1;
		end
		print("cache.write:"," tickrate: ",cache.tickrate-cache.rate," key: ",key," action: ",action," ent: ",ent," value: ",value," sentto: ",to);
	else
		print("cache.read:"," netvarid: ",key," actionid: ",action," ent: ",ent);
	end
end