SWEP.Instructions="";
SWEP.PrintName="Hands";
SWEP.Author="";
SWEP.Purpose="";
SWEP.Contact="";
SWEP.Category="rw";
SWEP.Slot=0;
SWEP.SlotPos=0;
SWEP.DrawAmmo=false;
SWEP.DrawCrosshair=false;
SWEP.ViewModelFOV=50;
SWEP.ViewModelFlip=false;
SWEP.WorldModel="";
SWEP.ViewModel="";
SWEP.Spawnable=true;
SWEP.AdminOnly=true;
SWEP.Primary.ClipSize=-1;
SWEP.Primary.DefaultClip=-1;
SWEP.Primary.Automatic=false;
SWEP.Primary.Ammo="none";
SWEP.Secondary.ClipSize=-1;
SWEP.Secondary.DefaultClip=-1;
SWEP.Secondary.Automatic=false;
SWEP.Secondary.Ammo="none";

function SWEP:Initialize()
	self:SetHoldType("normal");
end

function SWEP:DrawHUD()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Deploy()
	return true;
end

function SWEP:Holster()
	return true;
end

function SWEP:Think()

end