ENT.Type			= "anim"
ENT.Base			= "base_gmodentity"
ENT.Spawmable		= true
ENT.PrintName		= "Energy"
ENT.Category		= "Balls"

function ENT:SetupDataTables()
 
    self:NetworkVar( "Bool", 0, "LaserBeam" )

end