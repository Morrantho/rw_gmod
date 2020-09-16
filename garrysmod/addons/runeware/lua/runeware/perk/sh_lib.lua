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