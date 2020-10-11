if !cmd.enabled then return; end

local CMD = {}

CMD.name = "dropmoney";
CMD.usage = "dropmoney <number>";
CMD.description = "Drop money infront of you."
CMD.power = role.member

function CMD.run( pl,args )
    if pl:isconsole() then cmd.help( CMD, pl, "Player only." ) return end
    if #args < 1 || args[1] == "" then cmd.help(CMD,pl); return; end
    local amt = tonumber(args[1])
    -- if amt < 0 then
    --     err( "You cannot drop negative amounts of money.", pl )
    --     return
    -- elseif !amt || pl:getmoney() < amt then
    --     err( "You are too poor to drop that much money.", pl )
    --     return
    -- end

    pl:setmoney( pl:getmoney() - amt )

    local money = ents.Create( "ent_money" )
    money:SetPos( pl:EyePos() + pl:GetAimVector() * 30 )
    money:Spawn()
    money:setamt(amt)

    local phys = money:GetPhysicsObject()

end

cmd.add(CMD,"drop","dropcash")