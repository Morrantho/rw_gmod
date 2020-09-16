if !cmd.enabled then return; end

local CMD = {}
CMD.name        = "spec"
CMD.description = "Spectates a player."
CMD.usage       = "/spec < SteamID / Name >"
CMD.power = role.admin
CMD.nocheck = true

function CMD.run(pl,args,argstr)

    if !pl:spectating() and ( #args < 1 || args[1] == "" ) then
    	cmd.help( CMD, pl )
    	return
    end

    local target

    if args[1] != "" then
        target = FindPlayer( args[1] )
        if !IsValid( target ) then err( "The target " .. args[1] .. " is not online.", pl ) return end
        if target == pl then err( "You cannot spectate yourself", pl) return end
        if pl.Spec and target == pl:GetObserverTarget() then err( "You are already spectating " .. target:getname() .. "." , pl ) return end
        -- TODO: State what player they're spectating.
        if target.Spec then err( "The player " .. target:getname() .. " is currently spectating someone.", pl ) return end
    end

    if args[1] != "" then
        pl:specplayer( target )
        success( "You are now spectating " .. target:getname() .. ".", pl )
    else
        pl:unspecplayer()
        success( "You are no longer spectating.", pl )
    end

end
cmd.add(CMD, "spec");