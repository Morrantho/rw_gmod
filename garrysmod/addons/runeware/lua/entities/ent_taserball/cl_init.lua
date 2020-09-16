include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	
	if self:GetLaserBeam() then
		for i = 1, 2 do
			local pos 		= self:GetPos()
			local offset 	= VectorRand( -200, 200 )
			offset.z		= math.random( -125,125 )
			pos				= pos + offset
			
			local tr = util.TraceLine( { start = self:GetPos(), endpos = pos , filter = self } )

			local mat = Material( "trails/electric" )
			render.SetMaterial( mat )
			render.DrawBeam( self:GetPos(), tr.HitPos, 5, 0, 1, Color( 255, 255, 255 ) )
		end
	end
	
end
