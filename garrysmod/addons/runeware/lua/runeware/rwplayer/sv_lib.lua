if !rwplayer.enabled then return; end
local hookadd=hook.Add;
local hookrun=hook.Run;
local plyall=player.GetAll;
local random=math.random;
local writebool=net.WriteBool;
local writeuint=net.WriteUInt;
local writestr=net.WriteString;
local vec=Vector;
local pl=FindMetaTable("Entity");
local player=player;

--[[ Hooks --]] 

function rwplayer.loadplayer(data,pl)
	rwplayer.onsetname(nil,{pl,data.name});
	rwplayer.onsetmoney(nil,{pl,data.money});
	rwplayer.setusermode(pl,0);
	rwplayer.setraiding(pl,false)
end
hookadd("db.loadplayer","rwplayer.loadplayer",rwplayer.loadplayer);

function rwplayer.playerspawn(pl)
	pl:SetWalkSpeed(rwplayer.walkspeed);
	pl:SetRunSpeed(rwplayer.runspeed);
	pl:SetSlowWalkSpeed(rwplayer.slowwalkspeed);
	pl:SetCrouchedWalkSpeed(rwplayer.crouchedwalkspeed);
	pl:SetLadderClimbSpeed(rwplayer.ladderclimbspeed);
	pl:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR);
	pl:SetViewOffset(vec(0,0,64));
	pl:SetViewOffsetDucked(vec(0,0,28));
	pl:SetStepSize(18);
	job.spawn(pl);
end
hookadd("PlayerSpawn","rwplayer.playerspawn",rwplayer.playerspawn);

function rwplayer.playerdeath( pl, inf, atk )
	pl:SetViewOffset(vec(0,0,64));
	pl:SetViewOffsetDucked(vec(0,0,28));
	pl:addstatus("ghosted");

	if atk:IsWorld() || inf:GetClass() == "rpg_missile" || inf:GetClass() == "npc_grenade_frag" || math.random() < 0.01 then
		for _, ply in ipairs( ents.FindInSphere( pl:GetPos(), 2000) ) do
			if ply:IsPlayer() && ply:TestPVS( pl ) then ply:doNetGib() end
		end
	end

end
hookadd("PlayerDeath","rwplayer.playerdeath",rwplayer.playerdeath);

function rwplayer.playerloadout(pl)
	job.loadout(pl);
	return true;
end
hookadd("PlayerLoadout","rwplayer.playerloadout",rwplayer.playerloadout);

function rwplayer.playerdisconnected(pl)
	if pl:spectating() then pl:unspecplayer() end
	if pl.Speccers then
		for ply, _ in pairs( pl.Speccers ) do 
			if IsValid(ply) then 
				ply:unspecplayer()
			else 
				ply = nil
			end
		end
	end
end
hookadd("PlayerDisconnected","rwplayer.playerdisconnected",rwplayer.playerdisconnected);

function rwplayer.playersetmodel(pl)
	local models   = pl:getjob().models;
	local mdl      = models[random(1,#models)];
	pl:SetModel(mdl);
	return true;
end
hookadd("PlayerSetModel","rwplayer.playersetmodel",rwplayer.playersetmodel);

--[[ RP Names --]] 

function rwplayer.onsetname(data,args)
	local pl      = args[1];
	local oldname = pl:getname();
	local newname = args[2];
	cache.write("name","set",pl,newname,plyall()); -- broadcast
	if data then
		hookrun("rwplayer.onsetname",pl,oldname,newname);
	end
end

function rwplayer.ongetname(data,args)
	local pl   = args[1];
	local name = args[2];
	local exists = #data > 0;
	if !exists then
		db.setname({pl:SteamID(),name},{pl,name},rwplayer.onsetname);
	end
	hookrun("rwplayer.ongetname",pl,name,exists); -- pass whether the name is reserved / in use
end

function rwplayer.setname(pl,name)
	db.getname({name},{pl,name},rwplayer.ongetname);
end

--[[ Money --]] 

function rwplayer.onsetmoney(data,args)
	local pl    = args[1];
	local money = args[2];
	cache.write("money","set",pl,money,pl); -- dont broadcast
	if data then
		hookrun("rwplayer.onsetmoney",pl,money);
	end
end

function rwplayer.setmoney(pl,money)
	db.setmoney({pl:SteamID(),money},{pl,money},rwplayer.onsetmoney);
end

--[[ Usermodes ]]

function rwplayer.setusermode(pl,mode)
	assert(mode>=0&&mode<=255,"You're using it wrong, ask pyg or snek.");
	cache.write("usermode","set",pl,mode,plyall());
end

function rwplayer.setraiding( pl, num )
	cache.write( "raiding", "set", pl, num, plyall() )
end

--[[ Demotes --]] 

function rwplayer.demote(by,tgt,rsn)
	if #rsn < 1 || #rsn > 32 then
		err("Demote reason must be between 1-32 characters.",by);
		return;
	end
	local byname,tgtname = by:getname(),tgt:getname();
	-- local omit = {[byidx]=1,[tgtidx]=1};
	-- local to = player.omit(omit);
	local to = plyall();
	local netdata = {by:SteamID(),tgt:SteamID(),rsn};
	local sent = prompt.send("demote",netdata,by,to);
	if !send then return; end
	local fmt = byname.." started a vote to demote "..tgtname.." for "..rsn;
	success(fmt);
end

--[[ Metas --]]

function pl:setusermode(mode)
	rwplayer.setusermode(self,mode);
end

function pl:setname(name)
	rwplayer.setname(self,name);
end

function pl:setmoney(money)
	rwplayer.setmoney(self,money);
end

function pl:demote(by,rsn)
	rwplayer.demote(by,self,rsn);
end

function pl:nominate(jobname)
	rwplayer.nominate(self,jobname);
end

function pl:vote(decision)
	rwplayer.vote(self,decision);
end

--[[ Spectate horsefuckery ]]-- made by div

function pl:specweapons( Give )
	if !Give then
		if self.SpecWeps then return end
		local weps = {}
		for i = 1, #self:GetWeapons() do weps[i] = self:GetWeapons()[i]:GetClass() end
		self:StripWeapons()
		self.SpecWeps = weps
	else
		if !self.SpecWeps then return end
		for i = 1, #self.SpecWeps do self:Give( self.SpecWeps[i] ) end
		self.SpecWeps = nil
	end
end

function pl:spectating()
	if self.Spec then return true end
	return false
end

function pl:specplayer( target )
	if !target || !IsValid( target ) then return end
	if !self.Spec then
		if self:InVehicle() then self:ExitVehicle() end
		self:DropObject()
		self:Flashlight( false )
		self:SpecWeapons( false )
		self:SetNoDraw( true )
		self.Spec =
		{
			["Target"]  = target,
			["Armor"]   = self:Armor(),
			["Health"]  = self:Health(),
			["Pos"]     = self:GetPos(),
			["Look"]    = self:EyeAngles()
		}
		self:SetMoveType( MOVETYPE_NOCLIP )
		self:SetNotSolid( true )
		self:Spectate( OBS_MODE_CHASE )
	end
	if !target.Speccers then target.Speccers = {} end
	target.Speccers[ self ] = true
	self:SetParent( target )
	self:SpectateEntity( target )
end

function pl:unspecplayer()
	if !self:spectating() then return end
	self:UnSpectate()
	if self:GetParent() then self:SetParent( nil ) end
	self:Spawn()
	self:SetMoveType( MOVETYPE_WALK )
	self:SetPos( self.Spec["Pos"] )
	self:SetEyeAngles( self.Spec["Look"] )
	self:SetHealth( self.Spec["Health"] || 100 )
	self:SetArmor( self.Spec["Armor"] || 0 )
	self:SetNoDraw( false )
	local target = self.Spec["Target"]
	if IsValid( target ) && target.Speccers[ self ] then
		if table.Count( target.Speccers ) == 1 then target.Speccers = nil else target.Speccers[ self ] = nil end
	end
	self:SpecWeapons( true )
	self.Spec = nil
end

-- [[ Gib Network Send ]]

util.AddNetworkString( "rw.NetGib" )
function pl:doNetGib()

	local rag = self:GetRagdollEntity()
	if IsValid(rag) then rag:Remove() end
	net.Start( "rw.NetGib" )
	net.Send( self )

end

--[[ Player Lib Extensions --]]

function player.omit(t)
	local all=plyall();
	local res={};
	for i=1,#all do
		if t[all[i]:EntIndex()] then continue; end
		res[#res+1]=all[i];
	end
	return res;
end

--[[ Netvars --]] 

cache.register({
	name="money",
	set=function(varid,ent,cached,money)
		cached[varid] = money;
		writeuint(money||0,30);
	end
});

cache.register({
	name="name",
	set=function(varid,ent,cached,name)
		cached[varid]=name;
		writestr(name||"");
	end
});

cache.register({
	name="usermode",
	set=function(varid,ent,cached,mode)
		cached[varid]=mode;
		writeuint(mode,8);
	end
});

cache.register({
	name="raiding",
	set=function(varid,ent,cached,raiding)
		cached[varid]=raiding;
		writebool(raiding);
	end
});