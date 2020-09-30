local CMD = {}

CMD.name = "raid";
CMD.usage = "raid";
CMD.description = "Starts a raiding process."
CMD.power = role.member

function CMD.run( pl )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    local status = choose( pl:israiding(), false, true )
    if !pl:israiding() && pl.raiddelay && pl.raiddelay > CurTime() then err( "You can not raid for " .. math.ceil( pl.raiddelay - CurTime() ) .. "s." ) return end
    local rtext = choose( pl:israiding(), "You are no longer raiding.", "You are now raiding." )
    rwplayer.setraiding( pl, status )
    success( rtext, pl )
    if status then pl.raiddelay = CurTime() + 300 return end
end

cmd.add(CMD)