local ent=FindMetaTable("Entity");
local keys=table.GetKeys;
local plyall=player.GetAll;
local push=table.insert;
door=door||{};
door.dbg=false;
door.enabled=door.enabled||true;
if !door.enabled then return; end
door.groups=door.groups||{};
door.doors=door.doors||{};
door.bits=door.bits||1;

function door.add(group,entidx,name)
	local groupidx=door.groups[group]||#door.groups+1;
	if !door.groups[groupidx] then door.groups[groupidx]={}; end
	door.groups[group]=groupidx;
	push(door.groups[groupidx],entidx);
	if !door.doors[entidx] then door.doors[entidx]={}; end
	door.doors[entidx][1]=groupidx;
	door.doors[entidx][2]=name;
	if door.dbg then
		print("door.add: group: ",group," name: ",name || true," entidx: ",entidx);
	end
	door.bits=tobits(groupidx);
end

function door.isdoor(ent)
	return door.types[ent:GetClass()]==true;
end
--return whether a door can be owned.
function door.isunownable(entidx)
	local data=door.doors[entidx];
	if !data||data[1]==door.groups.unownable||data[1]==door.groups.nexus then 
		return true;
	end
	return false;
end
--return whether a door is owned by anyone, including coowners
function door.isowned(entidx)
	local all=plyall();
	local data=door.get(entidx)||{};
	for i=1,#all do
		local doors=cache.get(all[i],"doors")||{};
		if doors[data[1]] then return true; end
	end
	return false;
end
--return whether a player owns a door.
function door.isowner(pl,entidx)
	local doors=cache.get(pl,"doors")||{};
	local data=door.get(entidx)||{};
	return doors[data[1]]==1;
end
--return whether a player coowns a door
function door.iscoowner(pl,entidx)
	local doors=cache.get(pl,"doors")||{};
	local data=door.get(entidx)||{};
	return doors[data[1]]==2;
end
-- return one door's groupid and title by ent index. [1]=groupid [2]=title
function door.get(entidx)
	return door.doors[entidx];
end
-- return doors in the same group by ent index.
function door.getneighbors(entidx)
	local groupid=door.get(entidx)[1];
	return door.groups[groupid];
end
-- return doors in the same group by groupname.
function door.getgroup(groupname)
	local groupid=door.groups[groupname];
	return door.groups[groupid];
end
-- get all owners of a door.
function door.getowners(entidx)
	local DOOR=door.get(entidx)||{};
	local groupid=DOOR[1];
	local o={};
	local all=plyall();
	for i=1,#all do
		local doors=cache.get(all[i],"doors")||{};
		if doors[groupid] then o[#o+1]=all[i]; end
	end
	return o;
end
-- returns the cumulative cost of a property.
function door.getcost(entidx)
	return #door.getneighbors(entidx)*door.cost;
end
-- Metas
function ent:isdoor()
	return door.isdoor(self);
end

function ent:isdoorunownable()
	return door.isunownable(self:EntIndex());
end

function ent:isdoorowned()
	return door.isowned(self:EntIndex());
end

function ent:isdoorowner(pl)
	return door.isowner(pl,self:EntIndex());
end

function ent:isdoorcoowner(pl)
	return door.iscoowner(pl,self:EntIndex());	
end

function ent:getdoor()
	return door.get(self:EntIndex());
end

function ent:getdoorneighbors()
	return door.getneighbors(self:EntIndex());
end

function ent:getdoorowners()
	return door.getowners(self:EntIndex());
end

function ent:getdoorcost()
	return door.getcost(self:EntIndex());
end