if !log.enabled then return; end
local COL_WHITE = Color(255,255,255)

local LOG = {}

LOG.name        = "death"
LOG.nicename    = "Death Logs"

local default   = log.mode("default", "%s(%s) killed %s(%s) with %s", COL_WHITE)
default:addnetvar("player", "steamid")
default:addnetvar("attacker", "steamid")

local suicide   = log.mode("suicide", "%s(%s) killed themselves", COL_WHITE)
suicide:addnetvar("player", "steamid")

local fall      = log.mode("fall", "%s(%s) died from fall damage", COL_WHITE)
fall:addnetvar("player", "steamid")

local npc       = log.mode("npc", "%s killed %s(%s)", COL_WHITE)
npc:addnetvar("player", "steamid")

local silent    = log.mode("silent", "%s(%s) died via KillSilent()", COL_WHITE)
silent:addnetvar("player", "steamid")


LOG.modes = { default, suicide, fall, npc, silent }

log.add(LOG)

if CLIENT then return end

local function logdeath( ply, inf, atk )
    local entry = { name = LOG.name }
    local pid = ply:SteamID()
    if ply == atk then
        entry.mode = LOG.modes.suicide
        entry.nwvars = 
        { 
            player = pid
        }
        log.write(entry, ply:Nick(), pid)
    else
        if !IsValid(atk) then
            entry.mode = LOG.modes.fall
            entry.nwvars = 
            { 
                player = pid 
            }
            log.write(entry, ply:Nick(), pid)
        elseif atk:IsPlayer() then
            local aid = atk:SteamID()
            entry.mode = LOG.modes.default
            entry.nwvars = 
            { 
                player = pid, 
                attacker = aid 
            }
            log.write(entry, atk:Nick(), aid, ply:Nick(), pid, inf:GetClass())
        else
            entry.mode = LOG.modes.npc
            entry.nwvars = 
            { 
                player = pid 
            }
            log.write(entry, atk:GetClass(), ply:Nick(), pid)
        end
    end
end

local function logsilentdeath( ply )
    local pid = ply:SteamID()
    local entry = {
        name = LOG.name,
        format = LOG.modes.silent,
        extra = 
        { 
            player = pid 
        },
    }

    log.write(entry, ply:Nick(), pid)
end

hook.Add("PlayerDeath", "log.death", logdeath)
hook.Add("PlayerSilentDeath", "log.silentdeath", logsilentdeath)