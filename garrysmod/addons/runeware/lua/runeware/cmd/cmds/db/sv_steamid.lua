local function SteamIDGrabber(ply, cmd, args)
local ncnm = args[1]
ncnm = string.lower(ncnm)

for k, v in ipairs(player.GetAll()) do
    if string.find(string.lower(v:Nick()), ncnm) then
        MsgN("Target's SteamID: " .. v:SteamID())
        return 
    end
end

MsgN("Target not found.")
end

concommand.Add("rw_steamid", SteamIDGrabber)