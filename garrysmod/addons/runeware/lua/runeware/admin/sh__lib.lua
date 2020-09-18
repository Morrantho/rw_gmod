admin=admin||{};
admin.enabled=admin.enabled||true;
admin.dbg=admin.dbg||false;
if !admin.enabled then return; end
local findmeta=FindMetaTable;
local pl=findmeta("Player");
local band=bit.band;

function pl:IsAdmin()
	return self:getrole()>role.moderator;
end

function pl:IsSuperAdmin()
	return self:getrole()>role.admin;
end

function pl:ismoderator()
	return self:getrole()>=3;
end

function pl:isdeveloper()
	return self:getrole()>=7;
end

function pl:isbanned()
	return self:getrole()==role.banned;
end

function pl:getusermode()
	return cache.get(self,"usermode")||0;
end

function pl:hasusermode(mode)
	return band(self:getusermode(),mode);
end

function pl:getpropcount()
	return self:GetCount("props");
end

function pl:isowner(ent)
	return ent.owner==self;
end