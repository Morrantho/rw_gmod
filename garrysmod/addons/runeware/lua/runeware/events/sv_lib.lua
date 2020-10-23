events = events || {}
events.enabled = events.enabled || true
if !events.enabled then return end
local hookadd = hook.Add

events.msgcolor = "lightblue"
events.lightnum = events.lightnum || {}
events.lightents = events.lightents || {}
events.waterlevel = events.waterlevel || 0
events.lightlevel = events.lightlevel || 26


function events.loadlightchars()
    if #events.lightnum > 0 then return end
    for i = 97, 122 do
        table.insert( events.lightnum, #events.lightnum + 1, string.char(i) )
    end
end
events.loadlightchars()

-- // Insert all lights into a table to properly grab them for future loops
function events.loadlights()

    timer.Simple(1, function()
        for _, light in ipairs ( ents.FindByClass("light") ) do
        	if light:_GetName() and light:_GetName() == "evr_l" then
                 table.insert( events.lightents, #events.lightents + 1, light )
                 light:Fire("SetPattern", "z")
        	end
         end
    end)

end

-- // Run to load in lights.
hookadd( "InitPostEntity", "events.loadlights", events.loadlights )

function events.updatewater( pl, btn )

    if pl.WaterDelay and pl.WaterDelay >= CurTime() then return false end
    local water = ents.FindByClass("func_water_analog")[1]
    -- // Unlikely, but include anyways.
    if !water then return end
    local pNum = 0.025
    local wTime = 0.25

    if btn:GetClass() == "func_button" then
        if btn:_GetName() == "water_up" and events.waterlevel < 1 then
    		pl.WaterDelay = CurTime() + wTime
    		events.waterlevel = math.Clamp( events.waterlevel + pNum , 0, 1 )
    		water:Fire( "SetPosition", events.waterlevel )
    		pmsg( pl, { events.msgcolor, "[Raise] ", "whitest", "Levels: " .. util.NiceFloat( events.waterlevel * 100 ) .. "%." } )
        elseif btn:_GetName() == "water_down" and events.waterlevel > 0 then
    		pl.WaterDelay = CurTime() + wTime
    		events.waterlevel = math.Clamp( events.waterlevel - pNum, 0, 1 )
    		water:Fire( "SetPosition", events.waterlevel )
    		pmsg( pl, { events.msgcolor, "[Lower] ", "whitest", "Levels: " .. util.NiceFloat( events.waterlevel * 100 ) .. "%." } )
    	end
    end

end
hookadd( "PlayerUse", "events.waterupdate", events.updatewater )

function events.updatelight( pl, btn )

    if pl.LightDelay and pl.LightDelay >= CurTime() then return false end
    -- // Unlikely.
    if !events.lightents then return end
    local wTime = 0.25

    if btn:GetClass() == "func_button" then
    	if btn:_GetName() == "evr_l_inc" and events.lightlevel < 26 then
    		pl.LightDelay = CurTime() + wTime
    		events.lightlevel = events.lightlevel + 1
    		for _, light in ipairs( events.lightents ) do light:Fire( "SetPattern", events.lightnum[ events.lightlevel ] ) end
            pmsg( pl, { events.msgcolor, "[Raise] ", "whitest", "Lights to: " .. events.lightlevel } )
    	elseif btn:_GetName() == "evr_l_dec" and events.lightlevel > 1 then
    		pl.LightDelay = CurTime() + wTime
    		events.lightlevel = events.lightlevel - 1
    		for _, light in ipairs( events.lightents ) do light:Fire( "SetPattern", events.lightnum[ events.lightlevel ] ) end
    		pmsg( pl, { events.msgcolor, "[Lower] ", "whitest", "Lights to: " .. events.lightlevel } )
    	end
    end

end
hookadd( "PlayerUse", "events.lightupdate", events.updatelight )