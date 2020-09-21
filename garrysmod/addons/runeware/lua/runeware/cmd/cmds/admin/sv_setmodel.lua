if !cmd.enabled then return; end
local CMD={};
CMD.name="setmodel";
CMD.usage="setmodel <model>";
CMD.description="Changes the model of the player you're looking at.";
CMD.power=role.developer;

function CMD.run(ply,args,argstr)

    if #args < 1 || args[1] == "" then cmd.help( CMD, ply ) return end
    local targ = ply:GetEyeTrace().Entity
    if !targ || !IsValid( targ ) then err( "You must be looking at a player.", ply ) return end
    if !util.IsValidModel( args[1] ) then err( "The model " .. args[1] .. " is not a valid model." ) return end
    targ:SetModel( args[1] )
    targ:EmitSound( "garrysmod/balloon_pop_cute.wav" )
    success( "You changed the model of " .. targ:getname(), ply )
end
cmd.add(CMD);