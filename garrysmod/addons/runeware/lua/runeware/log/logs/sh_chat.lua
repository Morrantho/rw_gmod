if !log.enabled then return; end
local COL_GREY = Color(155,155,155)
local COL_WHITE = Color(255, 255, 255)

local LOG = {}

LOG.name        = "chat"
LOG.nicename    = "Chat Logs"
LOG.power       = role.admin

local defaultchat = log.mode("default", "%s(%s): %s", COL_WHITE)
defaultchat:addnetvar("player", "steamid")


local teamchat = log.mode("team", "%s(%s) TEAM: %s", COL_GREY)
teamchat:addnetvar("player", "steamid")

LOG.modes = { defaultchat, teamchat }

log.add(LOG)

if CLIENT then return end

local function logchat(ply, txt, team)
    local id = ply:SteamID()
    local entry = {
        name = "chat",
        mode = team and 2 or 1,
        color = team and COL_GREY or nil,
        nwvars = 
        { 
            player = id
        }
    }

    log.write(entry, ply:Nick(), id, txt)
end

hook.Add("PlayerSay", "log.chat", logchat)