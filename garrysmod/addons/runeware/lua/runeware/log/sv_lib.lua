if !log.enabled then return; end
util.AddNetworkString("log.network")
log = log or {}

--------------------------------------------------------
-- Broadcasts a log to everyone allowed to access it  --
--------------------------------------------------------

---------------
-- Net Order --         
---------------
-- logid              
-- flags                
--      bits: 
--          0 = M 
-- mode if flag M, otherwise assumed 1
-- format fillers
-- network variables
-- time      
      
local function packsteamid( sid )
    if sid == "BOT" then return -1 
    elseif !sid:match("STEAM_%d:%d:%d") then return -2 end
    local U = tonumber(sid[7])    --Universe, 3 bits
    local T = tonumber(sid[9])    --Type, 1 bit
    local Z = tonumber(sid:sub(11)) --ID, 31 bits
    --Total: 35 bits

    --Source: https://developer.valvesoftware.com/wiki/SteamID

    return U, T, Z
end

function log.networklog( logname, entryid )
    local logclass = log.get(logname)
    local entry = log.getlogentry(logname, entryid)
    local mode = logclass.modes[entry.mode]

    if !mode then   --If the mode isn't found it defaults to mode 1
        entry.mode = 1
        mode = logclass.modes[1]
    end
    assert(mode, "Cannot select mode! (no valid default exists)")

    local players = {}
    
    for k, v in ipairs(player.GetAll()) do 
        if v:getpower() >= logclass.power then 
            players[#players + 1] = v 
        end
    end

    if #players < 1 then return end

    net.Start("log.network")
    --Write the logid
    net.WriteUInt(logclass.id, log.bits)

    local flags = 0
    local hasmode = mode.id != 1 or false

    flags = bit.bor(flags, hasmode and 1 or 0)

    --Write the flags
    net.WriteUInt(flags, 1)
    if hasmode then
        --Write the mode
        net.WriteUInt(mode.id, logclass.mbits) 
    end

    --This part sends the arguments for Format()
    for k, v in ipairs(entry.meta) do
        net.WriteString(v)
    end

    --This handles nwvars, those are kind of jank
    for k, v in ipairs(mode.netvars) do
        local nwv = entry.nwvars[v.name]
        -- assert(nwv, "All networked variables MUST be accounted for. Missing: "..v.name)

        if v.type == "string" then
            net.WriteString(nwv)
        elseif v.type == "steamid" then
            local U, T, Z = packsteamid(tostring(nwv))
            if U == -1 then
                net.WriteBool(true)
            elseif U == -2 then
                error("Unable to parse variable of type steamid ("..nwv..")")
            else
                net.WriteBool(false)
                net.WriteUInt(U, 3)
                net.WriteUInt(T, 1)
                net.WriteUInt(Z, 31)
            end
        elseif v.type == "tostring" then
            net.WriteString(tostring(nwv))
        elseif v.type == "float" then 
            net.WriteFloat(nwv)
        elseif v.type == "int" then
            nwv = bit.band(nwv, math.pow(2, v.size)) --No buffer overflow here
            net.WriteInt(nwv, v.size)
        end
    end

    net.WriteFloat(entry.time)
    net.Send(players)
end