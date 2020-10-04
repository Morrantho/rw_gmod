if !cache.enabled then return; end
local type=type;
local pairs=pairs;
local floor=math.floor;
local popf=table.remove;
local push=table.insert;
local netstart=net.Start;
local writeuint=net.WriteUInt;
local playergetall=player.GetAll;
local netsend=net.Send;
local getbyindex=ents.GetByIndex;
local getbysteamid=player.GetBySteamID;
local netstr=util.AddNetworkString;
local hookadd=hook.Add;
netstr("cache.write");

function cache.write(key,action,ent,value,to)
	-- if to && to:isconsole() then return; end
	local cacheid  = nil;
	if ent:IsPlayer() then
		cacheid=ent:SteamID();
	else
		cacheid=ent:EntIndex();
	end
	local netvarid=cache.netvars[key];
	local netvar=cache.netvars[netvarid];
	local funcid=netvar[action];
	local func=netvar[funcid];
	if !cache.data[cacheid] then cache.data[cacheid] = {}; end -- init if not already
	push(cache.msgs,function(dumpto)
		netstart("cache.write");
		writeuint(netvarid,8); -- key / field name to affect
		writeuint(funcid,netvar.funcbits); -- function id. this grows depending on # functions the netvar has.
		writeuint(ent:EntIndex(),13); -- entindex
		func(netvarid,ent,cache.data[cacheid],value); -- append w/e data the netvar needs
		if dumpto then
		--if dumpto&&!to then--if it was sent to one player, we probably dont need it.
			netsend(dumpto);
		else
			netsend(to||playergetall());
		end
		if cache.dbg then cache.log(key,action,ent,value,to); end
	end);
end

function cache.tick()
	if #cache.msgs < 1 then return; end
	if !cache.ticks then cache.ticks=0; end
	cache.rate=floor(#cache.msgs/cache.tickrate);
	if cache.ticks>cache.rate then
		local msg=popf(cache.msgs,1);
		push(cache.dump,msg);
		msg();
		cache.ticks=0;
	else
		cache.ticks=cache.ticks+1;
	end
end
hookadd("Tick","cache.tick",cache.tick);

function cache.PlayerDisconnected(pl)
	cache.data[pl:SteamID()] = nil;
end
hookadd("PlayerDisconnected","cache.PlayerDisconnected",cache.PlayerDisconnected);

function cache.loadplayer(data,pl)
	for i=1,#cache.dump do
		cache.dump[i](pl);
	end
end
hookadd("db.loadplayer","cache.loadplayer",cache.loadplayer);