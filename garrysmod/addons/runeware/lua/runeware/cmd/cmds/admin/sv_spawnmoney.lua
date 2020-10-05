if !cmd.enabled then return; end

local CMD       = {};
CMD.name        = "spawnmoney";
CMD.usage       = "spawnmoney <amt>";
CMD.description = "Spawns money infront of you, for debugging only.";
CMD.power       = role.developer;

function CMD.run(pl,args,argstr)

    local amt
    if !pl:Alive() then err( "You can not spawn money while dead.", pl ) return end

    if args[1] && args[1] != "" then
        amt = args[1]
    else
        amt = 40
    end

    -- // Div code.
    local trace = {}
    trace.start = pl:EyePos()
    trace.endpos = trace.start + pl:GetAimVector() * 85
    trace.filter = pl
    local tr = util.TraceLine(trace)

    local money = ents.Create( "ent_money" )
    money:SetPos( tr.HitPos )
    money:Spawn()
    money:setamt( amt )

    success( "You have spawned " .. string.Comma( amt ) .. "$.", pl )

end

cmd.add(CMD);