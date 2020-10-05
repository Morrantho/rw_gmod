
CreateClientConVar("rp_gibs", "1", true, false)

local GibModels =
{
	["Bones"] =
	{
		"models/gibs/hgibs_spine.mdl",
		"models/props_wasteland/prison_toiletchunk01b.mdl",
		"models/props_wasteland/prison_toiletchunk01m.mdl",
		"models/gibs/hgibs_scapula.mdl",
		"models/gibs/hgibs_rib.mdl"
	},

	["Meat"] =
	{
		"models/gibs/antlion_gib_small_3.mdl",
		"models/props_wasteland/prison_toiletchunk01i.mdl",
		"models/props_combine/breenbust_chunk06.mdl",
		"models/props_combine/breenbust_chunk05.mdl",
		"models/props_combine/breenbust_chunk04.mdl",
		"models/props_junk/watermelon01_chunk02a.mdl"
	},

	["BigMeat"] =
	{
		"models/props_junk/rock001a.mdl",
		"models/props_junk/watermelon01_chunk01a.mdl"
	}
}

local function gibRender()

	local Ply = LocalPlayer()
	local gibVar = GetConVar("rp_gibs")
	if gibVar:GetInt() == 0 then return end

	local GibTbl =
	{
		[1] =
		{
			["Name"] = "iBones",
			["TblName"] = "Bones",
			["Count"] = math.random( 2, 4 )
		},
		[2] =
		{
			["Name"] = "iMeat",
			["TblName"] = "Meat",
			["Count"] = math.random( 4, 8 )
		},
		[3] =
		{
			["Name"] = "iBigMeat",
			["TblName"] = "BigMeat",
			["Count"] = math.random( 1, 3 )
		},
		[4] = {}
	}

	-- // Multiply gibs by convar.
	-- // I am not responsible if someone cranks it to 100.
	if gibVar:GetInt() >= 2 then
		for i = 1,3 do
			GibTbl[i]["Count"] = GibTbl[i]["Count"] * gibVar:GetInt()
		end
	end

	for i = 1,3 do
		for iGib = 1, GibTbl[i]["Count"] do

			local MdlID = math.random( 1, #GibModels[ GibTbl[i]["TblName"] ] )
			local Mdl = GibModels[ GibTbl[i]["TblName"] ][ MdlID ]

			-- // We're putting the model inside of the function argument to enable clientside physics
			local Gib = ents.CreateClientProp( Mdl )
			local pPos = Ply:GetPos()

			Gib:SetAngles( Angle(math.random(-180,180), math.random(-180,180), math.random(-180,180) ) )
			Gib:SetPos(Vector( pPos.x, pPos.y, pPos.z + 45) )
			if i >= 2 then Gib:SetMaterial("models/flesh") end
			Gib:SetCollisionGroup( COLLISION_GROUP_WORLD )
			Gib:Spawn()
			Gib:PhysicsInit(SOLID_VPHYSICS)
			Gib:SetSolid(SOLID_VPHYSICS)

			local Phys = Gib:GetPhysicsObject()
			if IsValid(Phys) then Phys:Wake() Phys:SetVelocity( Gib:GetUp() * 400 ) end
			Gib:SetMoveType(MOVETYPE_VPHYSICS)
			Gib:SetRenderMode(RENDERMODE_TRANSALPHA)

			-- // Place into table
			GibTbl[4][ #GibTbl[4] + 1 ] = Gib

		end
	end

	-- // Spawn a skull too for effect
	local Skull = ents.CreateClientProp( "models/gibs/hgibs.mdl" )
	Skull:SetAngles( Angle(math.random(-90,90), math.random(-90,90), math.random(-90,90)) )
	Skull:SetCollisionGroup( COLLISION_GROUP_WORLD )
	Skull:Spawn()

	local Phys = Skull:GetPhysicsObject()
	if IsValid(Phys) then Phys:Wake() Phys:SetVelocity( Skull:GetUp() * 300) end
	GibTbl[4][ #GibTbl[4] + 1 ] = Skull

	timer.Simple( 8, function()
		for i = 1, #GibTbl[4] do
			local Ent = GibTbl[4][i]
			if IsValid( Ent ) then
				Ent:Remove()
				GibTbl[4][i] = nil
			end
		end
	end)

end

net.Receive( "rw.NetGib" , gibRender )