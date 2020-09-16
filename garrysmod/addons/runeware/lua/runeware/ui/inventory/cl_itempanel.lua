if !ui.enabled then return; end
local PANEL = {
    slots = {},
    vbartest = false,
    buttonsiz = 10
}

-------------------
-- *** Hooks *** --
-------------------
----------
-- Init --
----------

function PANEL:Init()
    self.grid = self:Add("DGrid")
    self.grid:SetRowHeight(50)
    self.grid:SetColWide(25)
    self.grid:SetContentAlignment(5)
    self.grid:SetCols(5)
end

-------------------
-- PerformLayout --
-------------------

function PANEL:PerformLayout(w, h)
    local parent = vgui.GetControlTable("DScrollPanel")
    if w and h then --These were nil for some fucking reason 
        local columns = self.grid:GetCols()
        local margin = self.buttonsiz + (w - columns * self.buttonsiz) / columns 

        print(margin)

        self.grid:SetColWide(margin)
        self.grid:SetRowHeight(margin)
    end

    self.grid:InvalidateLayout(true)
    parent.PerformLayout(self, w, h)
end

-------------------
-- OnSizeChanged --
-------------------

function PANEL:OnSizeChanged( w, h )

end

-------------------
-- *** Funcs *** --
-------------------

----------------
-- SetButtons --
----------------

function PANEL:SetButtons( num )
    assert(isnumber(num) and num >= 0, "Positive number expectecd for argument 1")

    local slots = #self.slots

    if slots < num then --Add more slots
        for i = slots + 1, num do 
            local slot = vgui.Create("DButton")
            slot:SetSize(20, 20)
            self.slots[i] = slot
            self.grid:AddItem(slot)
        end
        self:InvalidateLayout()
    elseif slots > num then --Remove slots
        for i = num + 1, slots do 
            self.slots[i]:Remove()
            self.slots[i] = nil
        end
        self:InvalidateLayout()
    end
end

-------------------
-- SetButtonSize --
-------------------

function PANEL:SetButtonSize( siz )
    self.buttonsiz = siz
    for i = 1, #self.slots do
        slot = self.slots[i]
        slot:SetSize(siz, siz)
    end
    self:InvalidateLayout()
end

ui.add("cl_itempanel", PANEL, "cl_dscrollpanel")

concommand.Add("pantest", function()
    local win = vgui.Create("DFrame")
    win:MakePopup()
    win:SetSize(300,600)
    win:Center()

    local i = win:Add("cl_itempanel")
    i:Dock(FILL)
    i:SetButtons(50)
    i:SetButtonSize(20)
end)