if !cmd.enabled then return; end

local CMD = {}

CMD.name = "throwmoney";
CMD.usage = "throwmoney <number>";
CMD.description = "Yeet a pile of cash."
CMD.power = role.member

function CMD.run( pl,args )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    if #args < 1 || args[1] == "" then cmd.help(CMD,pl); return; end
    local amt = tonumber(args[1])
    if amt < 0 then
        err( "You cannot throw negative amounts of money.", pl )
        return
    elseif !amt || pl:getmoney() < amt then
        err( "You are too poor to throw that much money.", pl )
        return
    end
    

    pl:setmoney( pl:getmoney() - amt )

    -- players will lose a few bucks if their amount is not divisable by 5
    for i=1,5 do
        local money = ents.Create( "ent_money" )
        money:SetPos( pl:EyePos() )
        money:Spawn()
        money:setamt(amt/5)
        local phys = money:GetPhysicsObject()
        local velocity = Vector(pl:GetAimVector() * 800 + Vector(math.random(-100, 100), math.random(-100,100), 0))
        phys:ApplyForceCenter(velocity)
    end
    
end

cmd.add(CMD,"throw","throwcash","tm")