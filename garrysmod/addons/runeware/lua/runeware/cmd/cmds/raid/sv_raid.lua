local CMD = {}

CMD.name = "raid";
CMD.usage = "raid";
CMD.description = "Starts a raiding process."
CMD.power = role.member

function CMD.run( pl )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    local status = choose( pl:israiding(), false, true )
    local rtext = choose( pl:israiding(), "You are no longer raiding.", "You are now raiding." )
    rwplayer.setraiding( pl, status )
    success( rtext, pl )
end

cmd.add(CMD)