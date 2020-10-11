local CMD = {}

CMD.name        = "gotoent";
CMD.usage       = "gotoent < entindex >";
CMD.description = "Teleports you to a specific entity based off it's index.";
CMD.power       = role.developer;

function CMD.run(pl,args,argstr)

    if !pl:Alive() then err( "You can not run this command while dead.", pl ) return end
    if #args < 1 || args[1] == "" then cmd.help(CMD,pl); return end
    local ent = ents.GetByIndex( args[1] )
    if !IsValid( ent ) then err( "The entity with an index of " .. args[1] .. " does not exist.", pl ) return end
    pl:SetPos( ent:GetPos() )
    pl:EmitSound("garrysmod/balloon_pop_cute.wav")
    success( "Successfully teleported you to " .. ent:GetClass() .. "[" .. args[1] .. "].", pl )
end

cmd.add(CMD);