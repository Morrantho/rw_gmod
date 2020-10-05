if !perk.enabled then return; end
local tableremove=table.remove;
local writeuint=net.WriteUInt;
local pl=FindMetaTable("Player");
local hookadd=hook.Add;
-- callback. loads them post-join
function perk.ongetperks(data,args)
	local pl=args[1];
	for i=1,#data do
		if !data[i] then continue; end
		local perkname=data[i].perk;
		local perkid=perk[perkname];
		local tier=data[i].tier;
		perk.onadd(nil,{pl,perkid,tier});
	end
end
-- callback. also used by cache for init.
function perk.onsetpoints(data,args)
	local pl=args[1];
	local points=args[2];
	cache.write("perkpoints","set",pl,points,pl);
end
-- callback to perk.add(), handles writing to cache. also used by cache for init.
function perk.onadd(data,args)
	local pl=args[1];
	local perkid=args[2];
	cache.write("perks","add",pl,args,pl);
end
-- callback to perk.remove()
function perk.onremove(data,args)

end
-- makes a query to set points to supplied points.
function perk.setpoints(pl,points)
	local sid=pl:SteamID();
	local params={sid,points};
	local args={pl,points};
	db.setperkpoints(params,args,perk.onsetpoints);
end
-- adding a perk. handles tiers.
function perk.add(pl,perkname)
	if perk.has(pl,perkname) then 
		err("You already have this perk or have reached its max tier.",pl);
		return;
	end
	if !perk.haspoints(pl,perkname) then
		err("You don't have enough perk points to make this purchase.",pl);
		return;
	end
	local sid=pl:SteamID();
	local perkid=perk[perkname];
	local _perk=perk[perkid];
	local tier=pl:getperk(perkname)+1;
	local params={sid,perkname,tier};
	local args={pl,perkid,tier};
	if tier>1 then
		db.updateperk(params,args,perk.onadd);
	else
		db.addperk(params,args,perk.onadd);
	end
	local pointsleft=perk.getpoints(pl)-_perk.cost;
	perk.setpoints(pl,pointsleft);
	local fmt = "You spent ".._perk.cost.." perk point(s) on "..perkname.." ";
	fmt = fmt..tier.."/".._perk.tiers..".";
	success(fmt,pl);
end

function perk.remove(pl,perkname)

end

function pl:setperkpoints(points)
	perk.setpoints(self,points);
end

-- post connect
function perk.loadplayer(data,pl)
	perk.onsetpoints(nil,{pl,data.perkpoints});
	local sid=pl:SteamID();
	db.getperks({sid},{pl},perk.ongetperks);
end
hookadd("db.loadplayer","perk.loadplayer",perk.loadplayer);

cache.register({
	name="perks",
	add=function(varid,ent,cached,data)	
		if !cached[varid] then cached[varid]={}; end -- init perks table
		cached[varid][data[2]]=data[3]; -- set perkid to current tier
		writeuint(data[2],8); -- 0-255
		writeuint(data[3],3); -- 0-7
	end
});

cache.register({
	name="perkpoints",
	set=function(varid,ent,cached,points)
		cached[varid]=points;
		writeuint(points,8);
	end
});