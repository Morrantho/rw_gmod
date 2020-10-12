local CMD = {}

CMD.name = "givemoney";
CMD.usage = "givemoney <number> <steamid / name>";
CMD.description = "Give money to the player infront of you."
CMD.power = role.member

function CMD.run( pl,args )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    local amt = args[1]
    if amt < 0 then
        err( "You cannot drop negative amounts of money.", pl )
        return
    end
    local trg = pl:GetEyeTrace().Entity
    if #args < 1 || args[1] == "" then cmd.help(CMD,pl) return end
    if #args < 2 || args[1] == "" then 
        local trg = pl:GetEyeTrace().Entity
        if !trg:IsPlayer() then
            cmd.help(CMD,pl) 
            return
        end
        if trg:GetPos():DistToSqr(pl:GetPos()) > 200^2 then
            err( "This player is too far to be given money.", pl )
            return
        end
        success( "You gave " .. trg:getname() .. " $" .. amt .. ".", pl )
        success( pl:getname() .. "gave you $" .. amt .. ".", trg )
        pl:setmoney( pl:getmoney() - amt )
        trg:setmoney( trg:getmoney() + amt )
        return
    else
        local trg = findplayer(args[2])
        if !trg then
            err( "This player is not online or does not exist", pl )
            return
        end
        if trg:GetPos():DistToSqr(pl:GetPos()) > 200^2 then
            err( "This player is too far to be given money.", pl )
            return
        end
        success( "You gave " .. trg:getname() .. " $" .. amt .. ".", pl )
        success( pl:getname() .. "gave you $" .. amt .. ".", trg )
        pl:setmoney( pl:getmoney() - amt )
        trg:setmoney( trg:getmoney() + amt )
    end
end

cmd.add(CMD,"give","gm","givecash","gc")