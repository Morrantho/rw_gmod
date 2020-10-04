if SERVER then
    util.AddNetworkString( "rw.dolockpick" )
    util.AddNetworkString( "rw.succeedlockpick" )
end

SWEP.Instructions = "LMB - Lockpick Door";
SWEP.PrintName = "Lockpick";

SWEP.Author = "Legacy";
SWEP.Purpose = "";
SWEP.Contact = "";
SWEP.Category = "rw";

SWEP.Slot = 5;
SWEP.SlotPos = 0;
SWEP.DrawAmmo = false;
SWEP.DrawCrosshair = false;
SWEP.ViewModelFOV = 50;
SWEP.ViewModelFlip = false;
SWEP.WorldModel = "models/weapons/w_crowbar.mdl";
SWEP.ViewModel = "models/weapons/c_crowbar.mdl";
SWEP.Spawnable = true;
SWEP.AdminOnly = true;
SWEP.Primary.ClipSize = -1;
SWEP.Primary.DefaultClip = -1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "none";
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.HandleMat = "phoenix_storms/black_brushes"
SWEP.EdgeMat = "phoenix_storms/pack2/redlight"

SWEP.PickLength = 10
SWEP.PickDist = 170

local PickSounds =
{
    [1] = "weapons/357/357_reload1.wav",
    [2] = "weapons/357/357_reload3.wav",
    [3] = "weapons/357/357_reload4.wav"
}

function SWEP:Initialize()
    self:SetHoldType("passive")
end

function SWEP:Deploy()
    self:DoViewMats()
    self:Fail(true)
    return true
end

function SWEP:Holster()
    self:DoViewMats(true)
    self:Fail(true)
    return true
end

function SWEP:DoViewMats( hols )

    local EdgeMat = self.EdgeMat
    local HandleMat = self.HandleMat

    if hols then EdgeMat,HandleMat = "","" end

    if CLIENT && IsValid( self.Owner ) then
        self.Owner:GetViewModel():SetSubMaterial( 1, EdgeMat )
        self.Owner:GetViewModel():SetSubMaterial( 0, HandleMat )
    end

    if ( CLIENT ) then
    	self:SetSubMaterial( 1, HandleMat )
    	self:SetSubMaterial( 0, self.EdgeMat )
    end

    if ( SERVER ) then
    	self:SetSubMaterial( 1, HandleMat )
    	self:SetSubMaterial( 0, EdgeMat )
    end

end

function SWEP:DoLockpick()

    if !self.Owner || !IsValid( self.Owner ) then return end
    local ent = self.Owner:GetEyeTrace().Entity
    if !ent || !IsValid( ent ) then return end

    self.Picking = true
    self.Door = ent
    self.StartTime = CurTime()
    self.EndTime = CurTime() + self.PickLength
    self:SetHoldType("pistol")

end

local function netpick()

    local wpn = LocalPlayer():GetActiveWeapon()
    local netwpn = net.ReadEntity()
    if !wpn || wpn:GetClass() != "weapon_lockpick" then return end
    if !netwpn || netwpn != wpn then return end
    netwpn:DoLockpick()

end
net.Receive("rw.dolockpick", netpick)

local function netsucceed()

    local wpn = LocalPlayer():GetActiveWeapon()
    local netwpn = net.ReadEntity()
    if !wpn || wpn:GetClass() != "weapon_lockpick" then return end
    if !netwpn || netwpn != wpn then return end
    netwpn:Succeed()

end
net.Receive( "rw.succeedlockpick", netsucceed )

function SWEP:Succeed()

    if !self.Owner || !IsValid( self.Owner ) then return end
    local ent = self.Owner:GetEyeTrace().Entity
    if !ent || !IsValid(ent) then self:Fail() return end

    if CLIENT then
        success( "You did it. Yeah.", self.Owner )
    end

    self:SetHoldType("passive")
    self.Picking = nil
    self.Door = nil

    if SERVER then
        ent:Fire( "unlock" )
        ent:Fire( "open" )
    end

end

function SWEP:Fail( silent )
    self.Door = nil
    self.Picking = nil
    self.PickDelay = CurTime() + 0.5
    self:SetHoldType("normal")
end

function SWEP:CanPrimaryAttack()
    if !self.Owner || !IsValid( self.Owner ) then return false end
    if self.PickDelay && self.PickDelay > CurTime() then return false end
    return true
end

function SWEP:PrimaryAttack()

    if !self.Owner || !IsValid( self.Owner ) then return end
    if !IsFirstTimePredicted() || !self:CanPrimaryAttack() then return end

    local ply = self.Owner
    local ent = ply:GetEyeTrace().Entity

    -- // It's necessary for the server to start the lockpick on a shared level, otherwise the client will start lockpicking.
    -- // Ditto for Succeed.
    if SERVER && IsValid( ent ) && door.isdoor( ent ) then
        if !ply:withinbounds( ent, self.PickDist ) then err( "That door is too far away.", ply ) self:Fail() return end
        if door.isunownable( ent:EntIndex() ) then err( "That door is not pickable." ) self:Fail() return end
        if !door.isowned( ent:EntIndex() ) then err( "That door is not owned.", ply ) self:Fail() return end
        net.Start("rw.dolockpick") net.WriteEntity(self) net.Send( ply )
        self:DoLockpick()
    end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end

function SWEP:Think()
    if self.Picking then
        if !self.Owner || !IsValid( self.Owner ) then self:Fail() return end
        if !self.StartTime || !self.EndTime then self:Fail() return end
        local ent = self.Owner:GetEyeTrace().Entity
        if !IsValid( ent ) then self:Fail() return end
        if ent != self.Door then self:Fail() return end
        if !self.Owner:withinbounds( ent, self.PickDist ) then self:Fail() return end
        if SERVER then

            if CurTime() >= self.EndTime then
                net.Start("rw.succeedlockpick")
                    net.WriteEntity( self )
                net.Send( self.Owner )
                self:Succeed()
                return
            end

            if !self.DelayTick || ( self.DelayTick && self.DelayTick <= CurTime() ) then
                local TimeLength = math.ceil( self.EndTime - CurTime() )
                success( "Picking... " .. TimeLength .. "s left.", ply )
                local PickSound = PickSounds[ math.random( 1, #PickSounds ) ]
                self.Owner:EmitSound( PickSound )
                self.DelayTick = CurTime() + 1
            end

        end
    end
end

-- // Div hud bar // --
function SWEP:DrawHUD()

    if self.Picking then

        self.Dots = self.Dots || ""
        local w = ScrW()
        local h = ScrH()
        local x,y,width,height = w / 2 - w / 10, h / 2, w / 5, h / 15
        draw.RoundedBox(0, x, y, width, height, Color(10,10,10,120))

        local time = self.EndTime - self.StartTime
        local curtime = CurTime() - self.StartTime
        local status = math.Clamp(curtime / time, 0, 1)
        local BarWidth = status * (width - 16)

        draw.RoundedBox(0, x + 8, y + 8, BarWidth, height - 16, Color( 255 - ( status * 255 ), 0 + ( status * 255 ), 0, 255) )

        draw.SimpleText("Picking Lock", "Trebuchet24", w / 2, h / 2 + height / 2, Color( 255, 255, 255, 255 ), 1, 1)

    end

end

-- // Weapon type translation from Jazz Joyce, primarily used for battering ram // --
-- // Honestly not even sure if this is even working? // --

local ActIndex = {
    [ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
    [ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
    [ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
    [ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
    [ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
    [ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
    [ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
    [ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
    [ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
    [ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
    [ "normal" ]		= ACT_HL2MP_IDLE,
    [ "fist" ]			= ACT_HL2MP_IDLE_FIST,
    [ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
    [ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
    [ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
    [ "duel" ]			= ACT_HL2MP_IDLE_DUEL,
    [ "camera" ]		= ACT_HL2MP_IDLE_CAMERA,
    [ "magic" ]			= ACT_HL2MP_IDLE_MAGIC,
    [ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER
}

function SWEP:SetWeaponHoldType( t )

    t = string.lower( t )
    local index = ActIndex[ t ]

    if ( index == nil ) then
        Msg( "SWEP:SetWeaponHoldType - ActIndex[ \"" .. t .. "\" ] isn't set! (defaulting to normal)\n" )
        t = "normal"
        index = ActIndex[ t ]
    end

    self.ActivityTranslate = {}
    self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
    self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
    self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
    self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
    self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
    self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
    self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
    self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
    self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
    self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
    self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
    self.ActivityTranslate [ ACT_MP_SWIM ] 						= index+9

    -- "normal" jump animation doesn't exist
    if t == "normal" then
    	self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
    elseif t == "passive" then
    	local pass = ActIndex["passive"]
    	local norm = ActIndex["normal"]
    	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] = pass + 3 -- @@@ check for heady sticking out?
    	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_IDLE_PHYSGUN + 3
    	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] = norm + 4
    end

    self:SetupWeaponHoldTypeForAI( t )

end