if !log.enabled then return; end
-----------------------------------------------------------------
--    So this is going to serve as an example for log docs     --
-- this means I'm gonna comment it as if a baby was reading it --
-----------------------------------------------------------------

local COL_RED = Color(255, 100, 100)

local LOG = {}

-- The first thing logs need is a name, this will serve as how they're accessed in both code and console
-- Keep it lowercase and one word
LOG.name        = "damage"       

-- nicename is what's going to be used for labels on panels and printing in console
LOG.nicename    = "Damage Logs"

-- power defines who can access it, if you leave this blank then it defaults to moderator, however i still include it for the sake of docs
LOG.power       = role.moderator

-- The first major step is defining your read/write modes
-- A read/write mode for logs is a number that tells the log how it's supposed to read and write the information it's given 
-- Here is where we define that behavior using the MODE structure
--                log.mode( string name, string format, color printcolor)
local default   = log.mode("default", "%s(%s) damaged %s(%s) for %s points using %s (hit: %s)", COL_RED)

-- In this case I named the first mode default, as it's the default behavior for damage logs

-- mode structure has a function called addnetvar, which tells the log engine a new variable is to be networked when this log is sent to the client
-- This structure allows for the types: string, steamid, int, and float. everything else is converted to a string via tostring
-- The steamid type is special, it takes a string, however it's optimized to send differently between server and client. 
-- mode:addnetvar(string varname, string vartype)
default:addnetvar("player", "steamid")
default:addnetvar("attacker", "steamid")

--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WHEN IT COMES TO LOG FILTERING: The log engine searches for SteamIDs in THESE variables! Meaning if you want your logs to have filters you MUST use them --
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ALSO ALL NETWORK VARIABLES MUST BE SET FOR EACH LOG! Failure to do so will raise errors and prevent your logs from sending --------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- The second structure is for fall damage, as such there's no attacker for me to use
local fall      = log.mode("fall", "%s(%s) took %s points of fall damage", COL_RED)
fall:addnetvar("player", "steamid")

-- Final structure is for other entities damaging the player, again only one player to network
local ent       = log.mode("ent", "%s damaged %s(%s) for %s points", COL_RED)
ent:addnetvar("player", "steamid")

-- Store these modes in the LOG.modes table
LOG.modes = { default, fall, ent }

-- Add the log to the system
log.add(LOG)

if CLIENT then return end

local HITGROUP = {
    [HITGROUP_HEAD]     = "Head",
    [HITGROUP_CHEST]    = "Chest",
    [HITGROUP_STOMACH]  = "Stomach",
    [HITGROUP_LEFTARM]  = "Left arm",
    [HITGROUP_RIGHTARM] = "Right arm",
    [HITGROUP_LEFTLEG]  = "Left leg",
    [HITGROUP_RIGHTLEG] = "Right Leg"
}

local function logdamage( ply, atk, hp, dmg )
    dmg = math.Round(dmg)
    
    local plyid = ply:SteamID()
    -- Every single mode has the player nwvar, so i set that here
    local data = 
        { 
            player = plyid 
        }

    -- This is the log write structure that will be fed to log.write()
    local write =
        { 
            -- Name it after the log
            name = "damage", 
            -- Include nwvar table
            nwvars = data 
        }

    if IsValid(atk) then
        if atk:IsPlayer() then
            atkid = atk:SteamID()
            -- Write to the attacker var in mode.default
            data.attacker = atkid

            -- Do note, in log.add() enumerations are created for each read/write mode based on the name you give, to make things easy and consistent
            write.mode = LOG.modes.default

            -- Write the log 
            -- log.write(table writestruct, varags VarsForFormat())
            log.write(write, atk:Nick(), atkid, ply:Name(), plyid, dmg, atk:GetActiveWeapon():GetClass(), HITGROUP[ply:LastHitGroup()] or "Other")
        else 
            -- Define mode.ent
            write.mode = LOG.modes.ent
            -- Write log
            log.write(write, atk:GetClass(), ply:Name(), plyid, dmg)
        end
    elseif atk:IsWorld() then
        -- Set mode.fall
        write.mode = LOG.modes.fall
        -- Write log
        log.write(write, ply:Name(), plyid, dmg)
    end
end

hook.Add("PlayerHurt", "logs.damage", logdamage)