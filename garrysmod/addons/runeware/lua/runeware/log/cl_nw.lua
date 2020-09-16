if !log.enabled then return; end
local dbg = false

local queue = {}

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

local function unpacksteamid( U, T, Z )
    return "STEAM_"..U..":"..T..":"..Z
end

local function receivelog( len, ply )
    --read the logid
    local logid = net.ReadUInt(log.bits)
    local logclass = log.get(logid)
    --read flags
    local flags = net.ReadUInt(1)

    local modeid
    if bit.band(flags, 1) == 1 then
        --read the mode
        modeid = net.ReadUInt(logclass.mbits)
    else
        --or assume 1
        modeid = 1
    end

    local mode = logclass.modes[modeid]
    assert(mode, "Invalid read/write mode received ("..modeid..")")

    local fillers = {}
    for i = 1, mode.fvars do
        --read Format args
        fillers[i] = net.ReadString()
    end

    local nwvars = {}
    for k, v in ipairs(mode.netvars) do
        local var
        if v.type == "string" or v.type == "tostring" then
            var = net.ReadString()
        elseif v.type == "steamid" then
            if net.ReadBool() then
                var = "BOT"
            else 
                var = unpacksteamid(net.ReadUInt(3), net.ReadUInt(1), net.ReadUInt(31))
            end
        elseif v.type == "float" then 
            var = net.ReadFloat()
        elseif v.type == "int" then
            var = net.ReadInt(v.size)
        end

        nwvars[v.name] = var
    end

    --read log time
    local time = net.ReadFloat()

    local data = {
        name = logclass.name,
        mode = mode.id,
        timeoverride = time,
        nwvars = nwvars
    }

    log.write(data, unpack(fillers))
    if dbg then
        print("Total message size: "..string.NiceSize(len))
        print("Logid", logid, logclass.name, "bits: "..log.bits)
        print("Flags", flags)
        print("Mode", mode.id, mode.name, bit.band(flags, 1) == 1 and "(Networked)" or "(Default)")
        print("Fillers "..mode.fvars)
        for i = 1, mode.fvars do
            print(i, fillers[i])
        end
        print("NWVars")
        for k, v in pairs(nwvars) do
            print("", k, v)
        end
        print("Time", time)
    end
end



local function receivingOldLogs( len, ply )

end

net.Receive("log.network", receivelog)