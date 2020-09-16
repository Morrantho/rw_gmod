if !door.enabled then return; end
local ent = FindMetaTable("Entity");
local pl=FindMetaTable("Player");
local getbyidx=ents.GetByIndex;
local writeuint=net.WriteUInt;
local getkeys=table.GetKeys;
-- door lib layout:
-- {
-- 	doors=
-- 	{
-- 		123={1,"Fat Argonian"},
-- 		234={2,""},
-- 		345={1,""},
-- 		456={2,""}
-- 	}
-- 	groups=
-- 	{
-- 		["nexus"]=1,
-- 		["ownable"]=2,
-- 		1=
-- 		{
-- 			123,
-- 			345
-- 		},
-- 		2=
-- 		{
-- 			234,
-- 			456
-- 		}
-- 	}
-- }
-- door cache layout:
-- groupid=ownerlevel. 1=owner,2=coowner
-- {
-- 	1=1,
-- 	2=2,
-- 	3=2
-- }

function door.own(pl,entidx)
	local e=getbyidx(entidx);
	local DOOR=door.get(entidx);
	if !IsValid(e)||!e:isdoor()||!DOOR[1]||e:isdoorunownable() then
		err("This is not an ownable property.",pl);
		return;
	end
	if e:isdoorowned() then
		err("This property is already owned.",pl);
		return;
	end
	local pldoors=cache.get(pl,"doors")||{};
	local npldoors=#getkeys(pldoors);
	if npldoors+1>door.maxproperties then
		err("You have already reached the maximum number of ownable properties.",pl);
		return;
	end
	local cost=#door.getneighbors(entidx)*door.cost;
	local money=pl:getmoney();
	if money-cost<0 then
		err("You can't afford this property.",pl);
		return;
	end
	pl:setmoney(money-cost);
	cache.write("doors","add",pl,{DOOR[1],1});
	success("You purchased this property for $"..cost..".",pl);
end

function door.coown(owner,coowner,entidx)
	local e=getbyidx(entidx);
	local DOOR=door.get(entidx);
	if !IsValid(e)||!e:isdoor()||!DOOR[1]||e:isdoorunownable() then
		err("This is not a sharable property.",owner);
		return;
	end
	if !e:isdoorowner(owner) then
		err("You don't own this property.",owner);
		return;
	end
	if e:isdoorcoowner(coowner) then
		err(coowner:getname().." already coowns this property.",owner);
		return;
	end
	cache.write("doors","add",coowner,{DOOR[1],2});--2=coowner
	success("You made "..coowner:getname().." a coowner of: "..DOOR[2]..".",owner);
	success(owner:getname().." made you a coowner of: "..DOOR[2]..".",coowner);
end

function door.unown(pl,entidx)
	local e=getbyidx(entidx);
	local DOOR=door.get(entidx);
	if !IsValid(e)||!e:isdoor()||!DOOR[1]||e:isdoorunownable() then
		err("This is not an unownable property.",pl);
		return;
	end
	if !e:isdoorowner(pl) then
		err("You don't own this property.",pl);
		return;
	end
	local owners=e:getdoorowners();
	for i=1,#owners do -- unown for coowners.
		if owners[i]==pl then continue; end
		pl:uncoowndoor(owners[i],entidx);
	end
	local money=pl:getmoney();
	local cost=(#door.getneighbors(entidx)*door.cost)/2;
	pl:setmoney(money+cost);
	cache.write("doors","remove",pl,DOOR[1]);
	success("You sold this property for $"..cost..".",pl);
end

function door.uncoown(owner,coowner,entidx)
	local e=getbyidx(entidx);
	local DOOR=door.get(entidx);
	if !IsValid(e)||!e:isdoor()||!DOOR[1]||e:isdoorunownable() then
		err("This is not an unsharable property.",owner);
		return;
	end
	if !e:isdoorowner(owner) then
		err("You don't own this property.",owner);
		return;
	end
	if !e:isdoorcoowner(coowner) then
		err(coowner:getname().." does not coown this property.",owner);
		return;
	end
	cache.write("doors","remove",coowner,DOOR[1]);
	success(coowner:getname().." is no longer a coowner of your property: "..DOOR[2]..".",owner);
	success("You are no longer a coowner of "..owner:getname().."'s property: "..DOOR[2]..".",coowner);
end

function pl:owndoor(entidx)
	door.own(self,entidx);
end

function pl:coowndoor(coowner,entidx)
	door.coown(self,coowner,entidx);
end

function pl:unowndoor(entidx)
	door.unown(self,entidx);
end

function pl:uncoowndoor(coowner,entidx)
	door.uncoown(self,coowner,entidx);
end

function ent:lock()
	if !self:isdoor() then return; end
end

function ent:unlock()
	if !self:isdoor() then return; end
end

function ent:knock()
	if !self:isdoor() then return; end
end

cache.register({
	name="doors",
	add=function(varid,ent,cached,data)
		if !cached[varid] then cached[varid]={}; end
		cached[varid][data[1]]=data[2];
		writeuint(data[1],6);//0-63 groupid
		writeuint(data[2],3);//ownership level. 1=owner,2=coowner
	end,
	remove=function(varid,ent,cached,groupid)
		if !cached[varid] then cached[varid]={}; end
		cached[varid][groupid]=nil;
		writeuint(groupid,6);//0-63
	end
});