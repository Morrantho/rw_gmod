if !role.enabled then return; end
local findmeta=FindMetaTable;
local writeuint=net.WriteUInt;
local hookadd=hook.Add;
local hookrun=hook.Run;
local type=type;
local isvalid=IsValid;
local pl=findmeta("Entity");

function role.loadplayer(data,pl)
	role.onset(nil,{pl,nil,data.role});
end
hookadd("db.loadplayer","role.loadplayer",role.loadplayer);

function role.ongetplayer(data,args)
	local sid=args[1];
	local _admin=args[2];
	local rolename=args[3];
	local exists=#data>0;
	if exists then
		db.setrole({sid,rolename},{sid,_admin,rolename},role.onset);
	end
	hookrun("role.ongetplayer",sid,_admin,rolename,exists);
end

function role.onset(data,args)
	local pl=args[1];
	local _admin=args[2];
	local rolename=args[3];
	if isvalid(pl) then--they were online
		local roleid=role[rolename];
		cache.write("role","set",pl,roleid);
	end
	if data&&!pl:isconsole() then--not set by cache
		hookrun("role.onset",data[1],_admin,rolename);
	end
end

function role.set(pl,_admin,rolename)
	if type(pl)=="string" then
		db.getplayer({pl},{pl,_admin,rolename},role.ongetplayer);
	else
		db.setrole({pl:SteamID(),rolename},{pl,_admin,rolename},role.onset);
	end
end

function pl:setrole(_admin,rolename)
	role.set(self,_admin,rolename);
end

cache.register({
	name="role",
	set=function(varid,ent,cached,roleid)
		cached[varid]=roleid;
		writeuint(roleid,role.bits);
	end
});