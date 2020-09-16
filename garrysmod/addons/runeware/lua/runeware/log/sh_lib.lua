log = log or {}
log.dbg=log.dbg||false;
log.enabled=log.enabled||false;
log.logdata = log.logdata or {}
log.bits = log.bits or 1
if !log.enabled then return; end

local COLOR_WHITE = Color(255, 255, 255)
local DEF_LIMIT = 1000

local NETVAR_LOOKUP = {
    string = true,
    int = true,
    float = true,
    steamid = true,
    tostring = true 
}

-----------------
-- Local funcs --
-----------------
local function containssteamid( log, steamid ) --For checking if a nwvar is a given steamid
    for k, v in pairs(log.nwvars) do
        if v == steamid then return true end
    end

    return false
end

local function addnetvar( self, name, type, size )
    assert(isstring(name), "String expected for argument 1")
    assert(isstring(type), "String expected for argument 2")

    if !NETVAR_LOOKUP then type = "tostring" end
    if type == "int" then
        assert(isnumber(size), "Size required for type: integer")
    end

    local idx = #self.netvars + 1

    local NETVAR = {
        type = type,
        size = size,
        name = name,
        id = idx
    }

    self.netvars[idx] = NETVAR
    self.netvars[name] = idx
end

local function getnetvar( self, name )
    local ret = self.netvars[name]
    if isnumber(ret) then
        ret = self.netvars[name] --String name is actually a reference to the integer ID which points to the object
    end

    return ret or false 
end

------------------------------
-- Creates a new log object --
------------------------------

function log.add( logclass )
    assert(istable(logclass), "Table expected for argument 1")
    assert(isstring(logclass.name), "name required for log class object")

    logclass.modes = logclass.modes or { 
        log.mode("default", "", COLOR_WHITE)
    }
    logclass.limit = logclass.limit or DEF_LIMIT
    logclass.nicename = logclass.nicename or logclass.name
    logclass.power = logclass.power or role.moderator

    local idx = log.logdata[logclass.name] or #log.logdata + 1

    --Let each mode know what it's id is and create enums
    for k, v in ipairs(logclass.modes) do
        v.id = k
        logclass.modes[v.name] = k
    end


    logclass.startpos = 0
    logclass.cache = {}
    logclass.id = idx
    logclass.mbits = tobits(#logclass.modes) --We need this to network the minimal number of bits to know which mode is in use

    log.logdata[idx] = logclass
    log.logdata[logclass.name] = idx

    log.bits = tobits(idx) --We need this to network the minimal number of bits to know which log is being accessed
end

---------------------------------------
-- Returns the number of stored logs --
---------------------------------------

function log.count( logname )
    return #log.get(logname).cache
end

-----------------------------
-- Returns if a log exists --
-----------------------------

function log.exists( logname )
    if log.logdata[logname] then return true end
    return false
end

--------------------------------------
-- Retreives an existing log object --
--------------------------------------

function log.get( logid )
    local t = type(logid)
    if t == "string" then   --This function accepts both name and index
        logid = log.logdata[logid] != nil and log.logdata[logid] or logid
    end
    
    local ret = log.logdata[logid]

    assert(ret, "Unknown log "..tostring(logid))
    return ret
end

-----------------------------------------
-- Retreives a log entry from the logs --
-----------------------------------------

function log.getlogentry( name, index )
    local logentry = log.get(name)

    if !logentry then return end

    local pos = logentry.startpos + index
    local siz = #logentry.cache

    if pos > siz then pos = pos % siz end

    return logentry.cache[pos]
end

----------------------------------------------
-- Iterates through logs with given filters --
----------------------------------------------

function log.iterate( name, start, len, filter )
    local curlog = log.get(name)

    if !curlog then return function() end end

    local pos = start and curlog.startpos + start or curlog.startpos + 1
    if pos > curlog.limit then 
        local nlen = curlog.limit - start + 1
        pos = pos % curlog.limit
        if !len or len > nlen then len = nlen end  
    end
    local begin = pos
    local count = #curlog.cache
    local logcap = curlog.limit
    local completedloop = false
    
    return function()
        ::restart::
        local ret

        if len then 
            if len > 0 then
                len = len - 1
            else 
                return
            end
        end
        
        if count >= logcap then
            if pos > curlog.startpos and completedloop then 
                return
            else
                ret = curlog.cache[pos]
                pos = pos + 1

                if pos > #curlog.cache then
                    completedloop = true
                    pos = 1
                end
            end
        else
            ret = curlog.cache[pos]
            pos = pos + 1
        end        

        if filter and ret and not containssteamid(ret, filter) then
            if len then 
                len = len + 1
            end
            ret = nil
            goto restart
        end

        return ret
    end
end

---------------------------
-- Creates a MODE object --
---------------------------

function log.mode( name, format, color )
    assert(isstring(name), "String required for argument 1")
    assert(isstring(format), "String required for argument 2")
    assert(IsColor(color), "Color required for argument 3")

    local MODE = {
        name = name,
        format = format,
        color = color,
        fvars = format:occurrences("%s"),
        netvars = {},
        getnetvar = getnetvar,
        addnetvar = addnetvar
    }

    return MODE
end

-------------------------------
-- Writes to an existing log --
-------------------------------

function log.write( logdata, ... )
    assert(isstring(logdata.name), "Log name required")
    if logdata.mode then assert(isnumber(logdata.mode), "Number or no value expected for mode") else logdata.mode = 1 end
    if logdata.timeoverride then assert(isnumber(logdata.timeoverride), "Number or no value expected for timeoverride") end
    if logdata.nwvars then assert(istable(logdata.nwvars), "Table or no value expected for nwvars") end

    local logclass = log.get(logdata.name) 
    local writepos

    if #logclass.cache >= logclass.limit then        --When writing logs I have a sort of virtual indexing going on, so that the least significant entry is overwritten
        logclass.startpos = logclass.startpos + 1
        if (logclass.startpos > logclass.limit) then
            logclass.startpos = 0 
        end
        writepos = logclass.startpos
    else
        writepos = #logclass.cache + 1
    end

    local format = logclass.modes[logdata.mode].format||"";

    local logentry = {
        -- str = Format(format, ...),
        str = "", -- yell at me later, im tired of arg 4 spamming console cause nil - pyg
        log = logclass,
        modeobj = logclass.modes[logdata.mode],
        time = logdata.timeoverride or os.time(),
        nwvars = logdata.nwvars or {},
        rawPos = writepos,
        mode = logdata.mode or 1,
        meta = {...}
    }

    logclass.cache[writepos] = logentry

    if CLIENT then return end

    log.networklog(logdata.name, #logclass.cache)
end