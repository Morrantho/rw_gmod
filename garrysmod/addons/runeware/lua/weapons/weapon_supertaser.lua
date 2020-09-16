AddCSLuaFile()
SWEP.Author					= "Colossal"
SWEP.Base					= "weapon_base"
SWEP.PrintName				= "Super Taser"
SWEP.Instructions			= [[
Left-click: Shoot a electric beam that slows targets down

Right-click: Deploy a ball of electricity that slows targets down]]
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= "models/weapons/c_rpg.mdl"
SWEP.ViewModelFlip			= false
SWEP.UseHands				= true
SWEP.WorldModel				= "models/weapons/w_rocket_launcher.mdl"
SWEP.HoldType				= "RPG"

SWEP.Weight 				= 5
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= false

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true

SWEP.Primary.ClipSize		=  100
SWEP.Primary.DefaultClip	=  100
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Automatic		= true
SWEP.Primary.Recoil			= 0.2
SWEP.Primary.Damage			= 3
SWEP.Primary.NumShots		= 8
SWEP.Primary.Spread			= 0.002
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay			= 0.3

SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Recoil		= 5

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
	if( not self:CanPrimaryAttack() ) then
		return
	end
	
	local ply = self:GetOwner()
	local target = Entity( 1 ):GetEyeTrace().Entity
	
	local eyeang = self.Owner:EyeAngles()
	
	ply:LagCompensation( true )
	
	local Bullet = {}
		Bullet.Num		=	self.Primary.NumShots
		Bullet.Src		= 	ply:GetShootPos()
		Bullet.Dir		= 	ply:GetAimVector()
		Bullet.Spread		=	Vector( self.Primary.Spread, self.Primary.Spread, self.Primary.Spread )
		Bullet.Tracer		=	1
		Bullet.Damage		=	self.Primary.Damage
		Bullet.AmmoType		=	self.Primary.Ammo
		Bullet.Force		=	-1
		Bullet.TracerName 	= 	"ToolTracer"
		
	self:FireBullets( Bullet )

	if target:IsPlayer() then
		target:addstatus("slowed")
	end

	self:EmitSound( "ambient/levels/labs/electric_explosion5.wav", 75, 100, 0.2 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay)

	self.Owner:ViewPunch( Angle( -0.2, 0, 0 ) )
	self:TakePrimaryAmmo( 1 )

	ply:LagCompensation( false )
	
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	return true
end

function SWEP:SecondaryAttack()

	local ply = self:GetOwner()

	if( !self:CanSecondaryAttack() ) then
		return
	end


	if ( self:Clip1() <= 0 ) then
		self:EmitSound( "weapons/pistol/pistol_empty.wav" )
		self:SetNextSecondaryFire(CurTime() + 1)
		self:Reload()
		return
	end

	if ( self:Clip1() < 20  ) then
		self:EmitSound( "weapons/physcannon/physcannon_dryfire.wav" )
		self:ShootEffects()
		self:SetNextSecondaryFire(CurTime() + 0.5)
		return
	end

	self:TakePrimaryAmmo( 20 )
	self:ShootEffects()
	if SERVER then
		local ball = ents.Create ("ent_taserball")
		

		ball:SetPos(ply:EyePos() + (ply:GetAimVector() ) * 5 )
		ball:Spawn()
		ball:SetOwner( self.Owner )
		

		ply:EmitSound( "weapons/ar2/npc_ar2_altfire.wav" )
		
		
		self:SetNextSecondaryFire(CurTime() + 0.8)
		
		local phys = ball:GetPhysicsObject()
		local velocity = ply:GetAimVector() * 900 * phys:GetMass() + ply:GetVelocity()*20
		phys:ApplyForceCenter(velocity)
	end
	if CLIENT then
		self.Owner:ViewPunch( Angle( -self.Secondary.Recoil ) )
	end 
end