if !log.enabled then return; end
local COL_WHITE = Color(255, 255, 255)

local LOG = {}

LOG.name = "prop"
LOG.nicename = "Prop Logs"

local default = log.mode("default", "%s(%s) spawned %s", COL_WHITE)
default:addnetvar("player", "steamid")

LOG.modes = { default }

log.add(LOG)

if CLIENT then return end

local function logprop( ply, mdl, ent )
    local pid = ply:SteamID()
    local entry = {
        name = LOG.name,
        mode = LOG.modes.default,
        nwvars = {
            player = pid,
        }
    }

    log.write(entry, ply:Name(), pid, mdl)
end

hook.Add("PlayerSpawnedProp", "log.prop", logprop)