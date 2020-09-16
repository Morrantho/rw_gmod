AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

	local range 	= 200

	local damage 	= 0

	local fireRate 	= 1

	local HP		= 250

function ENT:Initialize()

	self:SetModel("models/maxofs2d/hover_basic.mdl")
	self:PhysicsInitBox( Vector(-10, -10, -10), Vector(10, 10, 10) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionBounds( Vector(-10, -10, -10), Vector(10, 10, 10) )
	self.collided = false
	local phys = self:GetPhysicsObject()

	self:SetLaserBeam(false)
	
	if phys:IsValid() then
		phys:Wake()	
		phys:EnableGravity(true)
	end

	self:SetHealth( HP )

	timer.Simple (30, function()
		if self:IsValid() then
			self:Remove()
			self:EmitSound("ambient/energy/zap1.wav1", 75, 100, 100 );
		end
	end)
	
end



function ENT:PhysicsCollide(data, mat)
	if !self.collided then
		self.collided = true;
		local trg = data.HitEntity
		local phys = self:GetPhysicsObject();
		phys:EnableMotion(false);
		self:SetLaserBeam(true)
		if trg:IsPlayer() then
			self:FollowBone(trg, 3)
		end
		timer.Create("thing"..self:EntIndex(),fireRate,300,function()
			if self:IsValid() then
				self:EmitSound("weapons/stunstick/spark"..math.random(1,3)..".wav", 75, 100, 1 );
				local target = ents.FindInSphere( self:GetPos(), range );
				for k, v in pairs( target ) do
					local head = util.TraceEntity( { start = self:GetPos(), endpos = v:EyePos(), filter = self }, self )
					local neck = util.TraceEntity( { start = self:GetPos(), endpos = (v:GetPos()+v:EyePos())*0.80, filter = self }, self )
					local chest = util.TraceEntity( { start = self:GetPos(), endpos = (v:GetPos()+v:EyePos())*0.60, filter = self }, self )
					local torso = util.TraceEntity( { start = self:GetPos(), endpos = (v:GetPos()+v:EyePos())*0.40, filter = self }, self )
					local legs = util.TraceEntity( { start = self:GetPos(), endpos = (v:GetPos()+v:EyePos())*0.20, filter = self }, self )
					local feet = util.TraceEntity( { start = self:GetPos(), endpos = v:GetPos(), filter = self }, self )
					if v:IsNPC() && v:IsValid() && self:IsValid() then
						if head.Entity == v || neck.Entity == v || chest.Entity == v || torso.Entity == v || legs.Entity == v || feet.Entity == v then
							v:TakeDamage( damage, self.Owner, self.Owner )
						end
					end

					if v:IsPlayer() && v:IsValid() && self:IsValid() && self.Owner != v then
						if head.Entity == v || neck.Entity == v || chest.Entity == v || torso.Entity == v || legs.Entity == v || feet.Entity == v then
							v:TakeDamage( damage, self.Owner, self.Owner )
						end
					end
				end
				if timer.RepsLeft("thing"..self:EntIndex()) == 0 then 
					self:Remove();
					self:EmitSound("ambient/energy/zap1.wav1", 75, 100, 100 ) 
				end
			end
		end)
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if(self:Health() <= 0) then
		self:Remove()
		self:EmitSound("ambient/energy/zap1.wav1", 75, 100, 100 )
		self:SetLaserBeam(false)
	end
end