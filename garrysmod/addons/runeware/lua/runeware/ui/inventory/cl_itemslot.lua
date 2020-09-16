if !ui.enabled then return; end
local GRAD_CENT = Material("gui/center_gradient")

local PANEL = {}
local PARENT

---------------
-- Init func --
---------------

function PANEL:Init()
    if !PARENT then PARENT = vgui.GetControlTable("DModelPanel") end
end

--------------
-- Set Item --
--------------

function PANEL:SetItem( itemid, dura, quant )
    if itemid == 0 then
        if self:Entity() then
            self:Entity():Remove()
        end
    else
        local itemclass = item[itemid] or item.get(itemid)
        assert(itemclass, "Unknown item: "..itemid)
        self.itemclass = itemclass
        self.quantity = quant or 1
        self.durability = dura

        self:SetModel(itemclass.mdl)

        local e = self.Entity
        if !e then return end
        local mn,mx = e:GetRenderBounds()
        local size = 0
        size = math.max(size,math.abs(mn.x)+math.abs(mx.x))
        size = math.max(size,math.abs(mn.y)+math.abs(mx.y))
        size = math.max(size,math.abs(mn.z)+math.abs(mx.z))
        self:SetFOV(45)
        self:SetCamPos(Vector(size,size,size))
        self:SetLookAt((mn+mx)*0.5)
    end
end

-----------
-- Hooks --
--------------
-- Do Click --
--------------

function PANEL:DoClick()
    -- This panel is used with cl_inventory, which sets self.parent on creation
    if !self.parent then return end

    self.parent:ItemSelected(self)
end

-------------------
-- Layout Entity --
-------------------

function PANEL:LayoutEntity( e )
    return
end

-----------
-- Paint --
-----------

local RARE_COLOR = {
    Poor
}

function PANEL:PrePaint( w, h )
    local grey = color.get("grey")

    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(grey.r, grey.g, grey.b, 255)
    surface.SetMaterial(GRAD_CENT)

    surface.DrawTexturedRect(0, 0, w * 4, h * 4) --We want the grad to be in the bottom left corner
    surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:Paint( w, h ) 
    self:PrePaint(w, h)
    PARENT.Paint(self, w, h)
    self:PostPaint(w, h) 
end

function PANEL:PostPaint( w, h )
    local grey = color.get("grey")

    surface.SetDrawColor(grey.r, grey.g, grey.b, 255)
    surface.DrawOutlinedRect(0, 0, w, h)
end

ui.add("cl_itemslot", PANEL, "DModelPanel")