rwplayer=rwplayer||{};
rwplayer.dbg=rwplayer.dbg||false;
rwplayer.enabled=rwplayer.enabled||true;
if !rwplayer.enabled then return;end
local pl=FindMetaTable("Entity");
pl._Name=pl._Name||pl.Name;
pl._Nick=pl._Nick||pl.Nick;
pl._GetName=pl._GetName||pl.GetName;
pl._SteamID=pl._SteamID||pl.SteamID;

function pl:getname()
	return cache.get(self,"name")||"BOT";
end

function pl:getmoney()
	return cache.get(self,"money");
end

function pl:Name()
	return self:getname();
end

function pl:Nick()
	return self:getname();
end

function pl:GetName()
	return self:getname();
end

function pl:SteamID()
	if !IsValid(self)&&self:EntIndex()==0 then return "CONSOLE"; end
	return pl._SteamID(self);
end

function pl:israiding()
	return cache.get(self,"raiding")
end

function pl:withinbounds( ent, dist )
	if !ent then return false end
	return self:GetPos():DistToSqr( ent:GetPos() ) < ( dist * dist )
end