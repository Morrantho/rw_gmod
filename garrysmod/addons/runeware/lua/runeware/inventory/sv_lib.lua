if !inventory.enabled then return; end
local abs=math.abs;
local ceil=math.ceil;
local clamp=math.Clamp;
local hookadd=hook.Add;
local writeuint=net.WriteUInt;
local pl=FindMetaTable("Entity");

function inventory.probe(pl,itemid,bagidx,itemidx,qty)
	local inv=pl:getinventory();
	if !qty then qty=1; end
	if bagidx>inventory.maxbags+1 then return; end
	local data=inv[bagidx][itemidx];
	local curqty=0;
	if data then curqty=data[2]; end
	local _item=item[itemid]||{};
	local stack=_item.stack||1;
	local nadd=stack-curqty;
	local left=curqty+qty-stack;
	if left<0 then left=0; end
	if nadd==stack&&left==0 then nadd=qty; end
	if !data||(data&&data[1]==itemid) then
		if nadd>0 then
			return bagidx,itemidx,nadd,left;
		end
	else
		if itemidx>item[inv[bagidx][1]].slots then
			bagidx=bagidx+1; itemidx=0;
		end
	end
	return inventory.probe(pl,itemid,bagidx,itemidx+1,qty);
end

function inventory.loadplayer(data,pl)
	cache.write("inventory","init",pl,{},pl);
	db.getinventory({pl:SteamID()},{pl},inventory.ongetinventory);
end
hookadd("db.loadplayer","inventory.loadplayer",inventory.loadplayer);

function inventory.ongetinventory(data,args)
	for i=1,#data do
		local itm=data[i];
		local netdata=
		{
			itm.bagidx,
			itm.idx,
			item[itm.bag],
			item[itm.item],
			itm.quantity,
			itm.durability
		};
		inventory.onadditem(itm,{netdata,args},true);
	end
end

function inventory.onadditem(data,args,shouldquery)
	local pl=args[2][1];
	cache.write("inventory","add",pl,args[1],pl);
	wait.now(.125,function()
		if !shouldquery && args[2][4] > 0 then
			inventory.additem(unpack(args[2]));
		end
	end);
end

function inventory.additem(pl,bagname,itemname,qty,dur)
	local itemid=item[itemname];
	local bagidx,itemidx,nadd,itemsleft=inventory.probe(pl,itemid,1,2,qty);
	if !bagidx||!itemidx then
		err("Your inventory is full.",pl);
		return;
	end
	local sid=pl:SteamID();
	local inv=pl:getinventory();
	if !bagname then bagname = item[inv[bagidx][1]].name; end
	local args={};
	args[1]={bagidx,itemidx,item[bagname],itemid,nadd,dur}; -- netdata
	args[2]={pl,bagname,itemname,itemsleft,dur}; -- callback args
	local params = {sid,bagidx,itemidx,bagname,itemname,nadd,dur};
	db.additem(params,args,inventory.onadditem);
end

function inventory.onremoveitem(data,args) -- removing a whole record
	cache.write("inventory","remove",pl,args,pl);
end

function inventory.onremoveitems(data,args) -- removing N quantity from a record
	cache.write("inventory","removen",pl,args,pl);
end

function inventory.removeitem(pl,bagidx,itemidx,qty)
	local inv=pl:getinventory();
	if !inv[bagidx][itemidx] then
		err("There is not an item in this bag slot.",pl);
		return;
	end
	local sid=pl:SteamID();
	local params={sid,bagidx,itemidx};
	local args={pl,bagidx,itemidx};
	if qty then -- remove only N quantity from the record
		params[#params+1]=qty;
		args[#args+1]=qty;
		db.updatequantity(params,args,inventory.onremoveitems);
	else -- remove the whole record.
		db.removeitem(params,args,inventory.onremoveitem);
	end
end

function pl:additem(itemname,quantity,durability)
	inventory.additem(self,"backpack",itemname,quantity,durability);
end

function pl:removeitem(idx)
	inventory.removeitem(self,idx);
end

cache.register({
	name="inventory",
	init=function(varid,ent,cached,data)
		cached[varid]={};
		cached[varid][1]={item["backpack"]};		
	end,
	add=function(varid,ent,cached,data)
		if !cached[varid][data[1]] then cached[varid][data[1]]={data[3]}; end
		if !cached[varid][data[1]][data[2]] then -- init item data
			cached[varid][data[1]][data[2]]={data[4],data[5],data[6]}; -- create the item
		else
			local oldqty = cached[varid][data[1]][data[2]][2];
			cached[varid][data[1]][data[2]][2]=oldqty+data[5]; -- update quantity.
		end
		writeuint(data[1],3); -- 0-7. bag index. inventory.maxbags is 4 by default. 
		writeuint(data[2],5); -- 0-31. item index. doubt bags will have more than this many slots
		writeuint(data[3],8); -- 0-255. bagid, same size as itemid. todo: dont write this unless init. we have enough info available on client to determine this
		writeuint(data[4],8); -- 0-255. itemid. lets try not to go over, cause we already have a lot.
		writeuint(data[5],7); -- 0-127. quantity.
		writeuint(data[6],7); -- 0-127 durability caps at 100, so this is fine.
	end,
	remove=function(varid,ent,cached,data)
		cached[varid][data[2]][data[3]]=nil;
		writeuint(data[2],3); -- 0-7. bag index.
		writeuint(data[3],5); -- 0-31. item index.		
	end,
	removen=function(varid,ent,cached,data)
		local oldqty=cached[varid][data[2]][data[3]][2];
		cached[varid][data[2]][data[3]][2]=clamp(oldqty-data[4],0,127);
		writeuint(data[2],3); -- 0-7. bag index.
		writeuint(data[3],5); -- 0-31. item index.
		writeuint(data[4],7); -- 0-127. qty.
	end
});