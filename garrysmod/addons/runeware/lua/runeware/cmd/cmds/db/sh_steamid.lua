local function SteamIDGrabber(ply, cmd, args)
local ncnm = args[1]
ncnm = string.lower(ncnm)
-- Here is where we begin looping thru the playerlist of the server, grabbing all players online. At this point is where the console command works.
for k, v in ipairs(player.GetAll()) do
    if string.find(string.lower(v:Nick()), ncnm) then
        MsgN("Target's SteamID: " .. v:SteamID())
        return 
    end
end
-- Following the loop, the code has looped thru all players upon running rw_steamid, should the argument be true, it will print the players SteamID
MsgN("Target not found.")
end
-- If the player is not found during the loop, it will fail and state the target was not found.
concommand.Add("rw_steamid", SteamIDGrabber)