local pl=FindMetaTable("Player");
perk=perk||{};
perk.dbg=perk.dbg||false;
perk.enabled=perk.enabled||true;
if !perk.enabled then return; end

function perk.register(data)
	local id=perk[data.name];
	if !id then id=#perk+1; end
	perk[id]=data;
	perk[data.name]=id;
	if perk.dbg then
		print("perk.register: "..data.name.." "..data.tree);
	end
end

function perk.exec(perkname,plys,cb)
	local perkid=perk[perkname];
	assert(perkid,"Failed to exec invalid perk: "..perkname);
	local exec=perk[perkid].exec;
	for i=1,#plys do
		if !plys[i]:hasperk(perkname) then continue; end
		local res=exec(plys[i]);
		if cb then cb(res); end
	end
end
-- return # of perk points or 0.
function perk.getpoints(pl)
	return cache.get(pl,"perkpoints")||0;
end
-- whether we have enough points to purchase it.
function perk.haspoints(pl,perkname)
	local cost=perk[perk[perkname]].cost;
	local pts=perk.getpoints(pl);
	return pts-cost>=0;
end
-- whether we have the perk already. for reuse, returns false until you reach max tier.
function perk.has(pl,perkname)
	local perkid=perk[perkname];
	local _perk=perk[perkid];
	local pperks=cache.get(pl,"perks")||{};
	local ptier=pperks[perkid]||0;
	return ptier>=_perk.tiers;
end
-- get a players current tier for the perk. 0 if they dont have the perk.
function perk.get(pl,perkname)
	local perkid=perk[perkname];
	local perks=cache.get(pl,"perks")||{};
	return perks[perkid]||0;
end
function pl:getperkpoints()
	return perk.getpoints(self);
end
-- whether we have enough perk points to purchase this perk.
function pl:hasperkpoints(perkname)
	return perk.haspoints(self,perkname);
end
-- whether we have reached the max tier for this perk.
function pl:hasperk(perkname)
	return perk.has(self,perkname);
end
-- the tier we're currently on for this perk.
function pl:getperk(perkname)
	return perk.get(self,perkname);
end

function pl:addperk(perkname)
	perk.add(self,perkname);
end

function pl:removeperk(perkname)
	-- perk.remove(self,perkname);
end
