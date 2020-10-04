if !admin.enabled then return; end
local findmeta=FindMetaTable;
local getcolor=color.get;
local pl=findmeta("Player");
--[[ sets the entities' owner. can be used for unowning. plz dont net ownership. --]]
function admin.ownent(pl,ent)
	local idx=ent:EntIndex();
	if IsValid(pl) then
		if !pl.ownedents then pl.ownedents={}; end
		pl.ownedents[idx]=true;
	else
		if IsValid(ent.owner) then
			ent.owner.ownedents[idx]=nil;
		end
	end
	ent.owner=pl;
end
--[[ freezes + nocollides the ent. can be used for unghosting. --]]
function admin.ghostent(ent,hasmotion,collgroup,mat,col)
	local phys=ent:GetPhysicsObject();
	phys:EnableMotion(hasmotion);
	ent:SetCollisionGroup(collgroup);
	ent:SetMaterial(mat);
	ent:SetRenderMode(RENDERMODE_TRANSCOLOR);
	ent:SetColor(col||Color(255,255,255));
end
--[[ determines whether a player's spawn delay has passed. --]]
function admin.isspawndelayed(pl)
	if pl.AdvDupe2 && pl.AdvDupe2.Pasting then return false; end
	if !pl.propspawndelay then pl.propspawndelay=-admin.propspawndelay; end
	local diff = CurTime()-pl.propspawndelay;
	if diff>admin.propspawndelay then
		pl.propspawndelay=CurTime();
		return false;
	end
	return true;
end

function admin.ispropblacklisted(mdl)
	return admin.propblacklist[mdl]==true;
end

function admin.handleblacklisted(pl,mdl)
	if admin.ispropblacklisted(mdl) then
		err(mdl.." is blacklisted.",pl);
		return false;
	end
	return true;
end

function admin.handleproplimit(pl)
	local props=pl:getpropcount();
	if props>admin.proplimit then
		err("You've hit the prop limit.",pl);
		return false;
	end
	return true;
end

function pl:IsAdmin()
	return self:getrole()>role.moderator;
end

function pl:IsSuperAdmin()
	return self:getrole()>role.admin;
end

function pl:isbanned()
	return self:getrole()==role.banned;
end

function pl:getusermode()
	return cache.get(self,"usermode")||0;
end

function pl:hasusermode(mode)
	return bit.band(self:getusermode(),mode);
end

function pl:getpropcount()
	return self:GetCount("props");
end

function pl:isowner(ent)
	return ent.owner==self;
end