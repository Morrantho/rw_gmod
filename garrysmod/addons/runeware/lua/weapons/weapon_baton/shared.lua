SWEP.Instructions="";
SWEP.PrintName="Baton";
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
SWEP.Spawnable=true;
SWEP.AdminOnly=true;
-- SWEP.ViewModel=Model("models/weapons/v_stunstick.mdl");
SWEP.ViewModel="models/weapons/c_stunstick.mdl"
SWEP.WorldModel=Model("models/weapons/w_stunbaton.mdl");
SWEP.Primary.ClipSize=-1;
SWEP.Primary.DefaultClip=-1;
SWEP.Primary.Automatic=true;
SWEP.Primary.Ammo="none";
SWEP.Secondary.ClipSize=-1;
SWEP.Secondary.DefaultClip=-1;
SWEP.Secondary.Automatic=true;
SWEP.Secondary.Ammo="none";
SWEP.UseHands=true;

local predicted=IsFirstTimePredicted;
local traceline=util.TraceLine;
local rand=math.random;
local swing="weapons/stunstick/stunstick_swing";
local spark="weapons/stunstick/spark";
local impact="weapons/stunstick/stunstick_impact";

local function trace(o,dist)
	return traceline({
		start=o:EyePos(),
		endpos=o:EyePos()+o:EyeAngles():Forward()*dist,
		filter=o,
		ignoreworld=true
	}).Entity;
end

function SWEP:Initialize()
	self.mode=1;
	self.inreload=false;
	self.atkspd=.6;
	self.atktime=0;
	self.difftime=0;
	self:SetHoldType("normal");
	self.modes=
	{
		{
			"M1:Want | M2:Unwant",
			function(pl)
				pl:want(self.Owner,"No reason specified.");
			end,
			function(pl)
				pl:unwant(self.Owner);
			end
		},
		{
			"M1:Arrest | M2:Unarrest",
			function(pl)
				pl:arrest(self.Owner);
			end,
			function(pl)
				pl:unarrest(self.Owner);
			end
		},
		{
			"M1:Warrant | M2:Unwarrant",
			function(pl)
				pl:warrant(self.Owner,"No reason specified.");
			end,
			function(pl)
				pl:unwarrant(self.Owner);
			end
		},
		{
			"M1:Damage | M2:Warn",
			function(pl)

			end,
			function(pl)
				
			end
		}
	};
end

function SWEP:DrawHUD()--why bother with a custom panel.
	local scrw,scrh=ScrW(),ScrH();
	local w,h=scrw/8,scrh/32;
	local x,y=scrw-w-h,scrh-h*2;
	surface.SetDrawColor(color.get("black"));
	surface.DrawRect(x,y,w,h);
	surface.SetDrawColor(color.get("blackest"));
	surface.DrawOutlinedRect(x,y,w,h);
	surface.SetFont("rw20");
	local txt=self.modes[self.mode][1];
	local txtw,txth=surface.GetTextSize(txt);
	draw.SimpleText(txt,"rw20",x+w/2,y+h/2,color.get("whitest"),1,1);
end

function SWEP:fire(atktype)
	self:SetHoldType("melee");
	self.atktime=CurTime();
	local vm=self.Owner:GetViewModel();
	local ent=trace(self.Owner,54);
	if !IsValid(ent)||!ent:IsPlayer() then
		self:EmitSound(swing..rand(1,2)..".wav",70,100);
		vm:SendViewModelMatchingSequence(vm:LookupSequence("hitkill1"));
		return;
	end
	self:EmitSound(impact..rand(1,2)..".wav",70,100);
	vm:SendViewModelMatchingSequence(vm:LookupSequence("hitcenter1"));
	if SERVER then self.modes[self.mode][atktype](ent); end
end

function SWEP:PrimaryAttack()
	self:fire(2);
	self:SetNextPrimaryFire(self.atktime+self.atkspd);
	self:SetNextSecondaryFire(self.atktime+self.atkspd);
end

function SWEP:SecondaryAttack()
	self:fire(3);
	self:SetNextPrimaryFire(self.atktime+self.atkspd);
	self:SetNextSecondaryFire(self.atktime+self.atkspd);
end

function SWEP:Reload()
	if !predicted()||self.inreload then return; end
	self.mode=choose(self.mode+1>#self.modes,1,self.mode+1);
	self.inreload=true;
end

function SWEP:Deploy()
	self:EmitSound(spark..rand(1,3)..".wav",70,100);
	return true;
end

function SWEP:Holster()
	self:EmitSound(spark..rand(1,3)..".wav",70,100);
	return true;
end

function SWEP:Think()
	if !self.Owner:KeyDown(IN_RELOAD)&&self.inreload then
		self.inreload=false;
	end
	self.difftime=CurTime()-self.atktime;
	if self.difftime>.1&&!self.inatk then
		self.Owner:SetAnimation(PLAYER_ATTACK1);
		self.inatk=true;
	end
	if self.difftime>self.atkspd then
		self:SetHoldType("normal");
		self.atktime=0;
		self.inatk=false;
	end
end