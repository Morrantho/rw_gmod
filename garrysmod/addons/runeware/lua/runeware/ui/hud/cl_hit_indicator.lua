if !ui.enabled then return; end
local indicators = {}
local WHITE_THRESH = 1600

local function createIndicator( key, color, pos, len )
    indicators[key] = {color = color, pos = pos, endtime = CurTime() + len}
end

--Shamelessly stolen from gmod wiki
local function circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

local function drawIndicators()
    if table.Count(indicators) <= 0 then return end 
    local wh, hh = ScrW() / 2, ScrH() / 2

	-- Reset everything to known good
	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()

	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(0)
	render.SetStencilCompareFunction(STENCIL_NEVER)
	render.SetStencilFailOperation(STENCIL_INCR)

    --This will filter out most of the circles we draw which will create
    --a crecent shape for the indicator
    surface.SetDrawColor(255, 255, 255)
    circle(960, 540, 50, 25)
	
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilFailOperation(STENCIL_KEEP)

    for k, v in pairs(indicators) do
        --Atan2 is a neat function to find the angle in rads between two points, but its shown as 0 deg being at the top of the circle so i have to subtract pi/2(90 degrees in rads)
        local life = v.endtime - CurTime()
        local pos = v.pos:ToScreen()

        if life <= 0 then
            indicators[k] = nil
            continue
        end

        local rad = math.atan2(pos.x - wh, pos.y - hh) - math.pi / 2
        --Creates a fade animation
        local alpha = math.Clamp(life, 0, 1)

        surface.SetDrawColor(v.color.r, v.color.g, v.color.b, 255 * alpha)
        circle(wh + math.cos(rad) * 18, hh - math.sin(rad) * 18, 35, 25)
	end

	-- Let everything render normally again
    render.SetStencilEnable( false )
end

local function tracemiss()
    local atkid = net.ReadUInt(7)
    local atk = Player(atkid)
    createIndicator(atkid, color.get("white"), atk:GetPos() + atk:OBBCenter(), 3)
end

local function tracehurt(args)
    local ply = LocalPlayer()
    if args.userid != ply:UserID() then return end 
    if args.attacker == 0 then return end
    if args.attacker == args.userid then return end

    local atk = Player(args.attacker)

    createIndicator(args.attacker, color.get("redder"), atk:GetPos() + atk:OBBCenter(), 3)
end

hook.Add("player_hurt", "traceHurt", tracehurt )
hook.Add("HUDPaint", "ui.dangerIndicator", drawIndicators)
net.Receive("ui.warningIndicator", tracemiss)