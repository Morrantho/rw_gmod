local findmeta=FindMetaTable;
local pl=findmeta("Entity");
-------------------------------------------------------------------------------
-- sh lib
-------------------------------------------------------------------------------
role=role||{};
role.enabled=role.enabled||true;
role.dbg=role.dbg||false;
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
-------------------------------------------------------------------------------
-- sh metas
-------------------------------------------------------------------------------
function pl:getrole()
	return cache.get(self,"role") || role.member;
end

function pl:getpower()
	return cache.get(self,"role") || role.member;
end

function pl:ismoderator()
	return self:getrole() >= 3
end

function pl:isdeveloper()
	return self:getrole() >= 7
end