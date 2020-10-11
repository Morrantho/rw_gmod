AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()

    self:SetModel( "models/props/cs_assault/Money.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(2)
    self.SpawnedIn = CurTime()
    local phys = self:GetPhysicsObject()
    phys:Wake()

end

function ENT:Use( user )

    if !user:IsPlayer() then return end
    local amt = self:GetAmt()
    user:setmoney( amt )
    success( "You picked up " .. string.Comma( amt ) .. "$.", user  )

    --local S = string.format("%s (%s) picked up $%s.", act:name(), act:SteamID(), string.Comma(amt) )
    --log.write("moneylogs", S, nil, {}, act:name(), act:SteamID(), amt )
    self:Remove()
end

function ENT:setamt(amt)
    if !amt or amt == "" then return end
    amt = tonumber(amt)
    self:SetAmt(amt)
end