include( "shared.lua" )

local cst = cam.Start3D2D;
local cen = cam.End3D2D;
local dso = draw.SimpleTextOutlined;
local dst = draw.SimpleText;

local flr = math.floor;
local rnd = math.random;

local wht = color.get("white");
local blk = color.get("black");

function ENT:Draw()

    self:DrawModel()

    local lp     = LocalPlayer();
    local dist    = lp:GetPos():DistToSqr(self:GetPos());
    if dist > 100000 then return; end

    local pos = self:GetPos()
    local angles = self:GetAngles()

    local alpha = 255 - flr( dist / 255 );
    col = Color(255, 255, 255, 255)
    col.a = alpha;
    local ol  = Color(blk.r,blk.g,blk.b,alpha);

    cst(pos + angles:Up() * 0.9, angles, 0.1)
    	dso( "$" .. string.Comma( self:GetAmt() ), "rw16", 0, 0, col, 1, 1, 4, ol);
    cen()

    angles:RotateAroundAxis( angles:Right(), 180 )

    cst(pos, angles, 0.1)
        dso( "$" .. string.Comma( self:GetAmt() ), "rw16", 0, 0, col, 1, 1, 4, ol);
    cen()

end