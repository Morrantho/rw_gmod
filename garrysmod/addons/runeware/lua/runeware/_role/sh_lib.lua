local findmeta=FindMetaTable;
local pl=findmeta("Entity");
-------------------------------------------------------------------------------
-- sh lib
-------------------------------------------------------------------------------
role=role||{};
role.enabled=true;
role.dbg=false;
role.bits=role.bits||1;
if !role.enabled then return; end

function role.add(name)
	local id=role[name];
	if !id then id=#role+1; end
	role[id]=name;
	role[name]=id;
	if role.dbg then
		print("role.add: "..name.." "..id);
	end
	role.bits=tobits(id);
end

function role.get(name)
	local id = role[name];
	if !id then return; end
	return role[id];
end

function role.getplayers(role_power)
	local all=player.GetAll();
	local plys={};
	for i=1,#all do
		if all[i]:getpower()==role_power then
			plys[#plys+1]=all[i];
		end
	end
	return plys;
end
-------------------------------------------------------------------------------
-- sh metas
-------------------------------------------------------------------------------
function pl:getrole()
	return cache.get(self,"role") || role.member;
end

function pl:getpower()
	return cache.get(self,"role") || role.member;
end

function pl:isbanned()
	return self:getrole() >= 1
end

function pl:ismoderator()
	return self:getrole() >= 3
end

function pl:isadmin()
	return self:getrole() >= 4
end

function pl:isdeveloper()
	return self:getrole() >= 7
end