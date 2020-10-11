ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Money"
ENT.Author = "Leggy"
ENT.RenderGroup = 8
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Amt" )
    if SERVER then
        self:SetAmt( 0 )
    end
end