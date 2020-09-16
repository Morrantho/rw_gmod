if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "sus";
CMD.usage       = "sus";
CMD.description = "Runs server information. Stats, Uptime, Status.";
CMD.power       = role.developer;
function CMD.run(pl,args,dir)
    if pl and IsValid(pl) then err( "This is a console only command", pl ) return end
    game.ConsoleCommand( "stats\n;rw_uptime\n;status\n" )
end
cmd.add(CMD);