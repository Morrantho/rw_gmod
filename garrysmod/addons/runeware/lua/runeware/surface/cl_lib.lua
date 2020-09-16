--------------------------------------------------------------------------------------------------------------------------------------------
-- Note: This function changes the current font and pos for surface draws! You'll have to change it back if you were already using a font --
--------------------------------------------------------------------------------------------------------------------------------------------
function surface.DrawScaledText(text, fontname, px, pos)
    local _font = font.scaled[fontname]
    assert(_font, "Unknown or nonscaled font type "..fontname)

    local base = math.Clamp(_font.start, math.ceil(px / 4) * 4,_font.finish)
    surface.SetFont(fontname..tostring(base))
    surface.SetTextPos(pos.x, pos.y)

    local w = ScrW()
    local h = ScrH()
    local matrix = Matrix()
    local dif = px / base

    matrix:Translate(pos)
	matrix:Rotate(Angle(0,0,0))
    matrix:Scale(Vector(dif,dif,dif))
    matrix:Translate(-pos)

    cam.PushModelMatrix(matrix)
    surface.DrawText(text)
    cam.PopModelMatrix()
end

local i = 12
local mode = true

hook.Add("HUDPaint", "painttest", function()
    local p = Vector(1700, 800)
    if mode then
        i = i + .1 
        if i >= 64 then mode = false end 
    else
        i = i - .1
        if i <= 12 then mode = true end
    end

    surface.DrawScaledText("Test text", "rw", i, p)
    surface.SetTextPos(p.x, p.y)
    surface.DrawText("Test text")
end)