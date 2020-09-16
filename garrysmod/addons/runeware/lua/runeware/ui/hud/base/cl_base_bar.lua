local PANEL = {}
local DEFAULT_MAT = Material("vgui/avatar_default")

function PANEL:Init()
    --Set a default 
    self.material = DEFAULT_MAT
    self.max = 100
    self.value = 100
    self.sidemargin = 20
    self.elemmargin = 5
    
    self.barcolor = color.get("white")

    self.showbar = true
    self.shownum = true
end

function PANEL:Paint( w, h )
    self:CalcValues()

    local bg = color.get("black")
    local white = color.get("white")
    local grey = color.get("grey")
    local matSiz = h * .90
    local matMargin = h - matSiz
    local textPos = self.sidemargin + matSiz + self.elemmargin
    local barHeight = h * .25

    --Draw bg
    surface.SetDrawColor(bg)
    surface.DrawRect(0, 0, w, h)

    --Draw image
    surface.SetDrawColor(white)
    surface.SetMaterial(self.material)
    surface.DrawTexturedRect(self.sidemargin, matMargin, matSiz, matSiz)

    --Draw text
    surface.SetTextColor(white)
    surface.SetTextPos(textPos, matMargin)
    surface.SetFont("rw28")
    surface.DrawText(self.value)
    surface.SetFont("rw32")
    surface.DrawText(self.value)
    surface.SetFont("rw36")
    surface.DrawText(self.value)
    --surface.DrawScaledText(self.value, "rw", matSiz, Vector(textPos, matMargin))
    
    --Draw bar bg
    local barPosX = surface.GetTextSize(self.value) + self.elemmargin
    local barSiz = w - barPosX - self.elemmargin - self.sidemargin 
    local barPosY = h / 2 - barHeight / 2
    surface.SetDrawColor(grey)
    surface.DrawRect(barPosX, barPosY, barSiz, barHeight)

    surface.SetDrawColor(self.barcolor)
    surface.DrawRect(barPosX, barPosY, self.max / barSiz * self.value, barHeight)
end

function PANEL:CalcValues()
    --This base function should be defined in child panels for setting self.max and self.value every frame
end

ui.add("cl_bar_base", PANEL, "cl_ddraggable") 