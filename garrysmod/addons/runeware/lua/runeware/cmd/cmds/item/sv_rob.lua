local CMD = {}

CMD.name = "rob";
CMD.usage = "rob";
CMD.description = "Rob a player infront of you."
CMD.power = role.member

function CMD.run( pl )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    local targ = pl:GetEyeTrace().Entity
    if pl.robdelay && pl.robdelay > CurTime() then err( "You can not rob for another " .. math.ceil( pl.robdelay - CurTime() ) .. "s.", pl ) return end
    if !targ || !IsValid( targ ) then err( "You must be looking at a player.", pl ) return end
    if targ:getmoney() <= 0 then err( "This player does not have any money.", pl ) return end
    local amt = math.random(50, 500)
    targ:setmoney( targ:getmoney() - amt )
    err( "You felt a shift in your pockets.", targ )
    success( "You successfully robbed $" .. amt .. ".", pl )
    pl.robdelay = CurTime() + 120
end

cmd.add(CMD)