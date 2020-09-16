if !log.enabled then return; end
local LOGS_PER_PAGE = 100
local LINE_BR = "-----------------------------------------"
local COL_TIMESTAMP = Color(252, 132, 40)

local dbg = false

local function rw_logs(ply, cmd, args, argstr)
    args = string.Explode(" ", argstr)

    local logname = args[1]
    local tgt = args[2]
    local page = args[3] 

    local logcount = log.count(logname)
    local pagecount = math.ceil(logcount / LOGS_PER_PAGE)

    if !tgt then
        page = 1   -- 1 arg = global page 1
    elseif !page then  
        local npage = tonumber(tgt)
        if npage and npage > 0 and npage <= pagecount then
            page = tgt
            tgt = nil
        else
            page = 1 --This code tries to figure out if you mean rw_log <name> <page> or rw_log <name> <player>
        end
    end

    if tgt == "" then tgt = nil end 

    if !log.exists(logname) then
        MsgC(Color(255, 100, 100), "The given log does not exist or cannot be accessed\n")
        return
    end

    local logclass = log.get(logname)

    if LocalPlayer():getpower() < logclass.power then
        MsgC(Color(255, 100, 100), "The given log does not exist or cannot be accessed\n")
        return
    end



    --Convert page from string to number
    local pageorigin = page
    page = tonumber(page)
    if !page or page < 1 then
        MsgC(Color(255, 100, 100), "Log page must be a number greater than 0 (given: "..pageorigin..")\n")
        return
    end

    local logstart = logcount - LOGS_PER_PAGE * page
    local len = LOGS_PER_PAGE

    if logstart < 1 then 
        len = len + (logstart - 1)
        logstart = 1
    end

    if page == 1 then --Odd bugg i havent figured out
        len = len + 1
    end

    --Checking if theres a target player and if they exist
    local name
    if tgt then 
        local find = findplayer(tgt)
        if find then
            name = find:Nick()
            tgt = find:SteamID()    
        end
    end

    MsgN(LINE_BR) 
    Msg("Displaying "..logclass.nicename.." page "..page.." of "..pagecount)
    if tgt then
        Msg(" for "..(name or "").."("..tgt..")")
    end
    Msg("\n")
    MsgN(LINE_BR)

    local i = 0
    for entry in log.iterate(logname, logstart, len, tgt) do
        local mode = logclass.modes[entry.mode]
        if dbg then 
            i = i + 1
            Msg(i.." ") 
        end
        MsgC(mode.color, "[")
        MsgC(COL_TIMESTAMP, os.date("%a, %b %d, %Y @ %X", entry.time))
        MsgC(mode.color, "]"..entry.str.."\n")
    end

    MsgN(LINE_BR) 
    Msg("End of "..logclass.nicename.."\n")
    MsgN(LINE_BR)
end

concommand.Add("rw_logs", rw_logs)