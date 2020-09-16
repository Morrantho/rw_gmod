if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "uptime";
CMD.usage       = "uptime";
CMD.description = "Prints the server uptime in HH:MM:SS.";
CMD.power       = role.developer;

function CMD.run(pl,args,dir)

    local upt = CurTime()
    local hours = math.floor( upt / 60 / 60 )
    local min = math.floor( ( upt - ( hours * 60 * 60 ) ) / 60 )
    local sec = math.floor( ( upt - ( hours * 60 * 60 ) - ( min * 60 ) ) )

    if (string.len(tostring(sec)) == 1) then sec = "0" .. sec end
    if (string.len(tostring(min)) == 1) then min = "0" .. min end

    local strupt = string.format("Uptime: %s Hours %s Minutes %s Seconds", hours, min, sec)

    if pl and IsValid(pl) then
        success( strupt, pl )
    else
        print( strupt )
    end
end
cmd.add(CMD);