if !cmd.enabled then return; end

local match         = string.match;
local randomname       = {};
randomname.name        = "randomname";
randomname.usage       = "randomname";
randomname.description = "Randomizes your name.";
randomname.power       = role.member;
randomname.re          = "%w";

function randomname.run(pl,args,argstr)
    pl.lpchk = 0
    randomname.check(pl,pl.lpchk)
end

function randomname.check( pl,lp )

    if !lp || !pl.lpchk then err( "An internal error has occured." ,pl ) return end
    if lp > 20 then err( "A random name could not be generated for you.", pl ) pl.lpchk = nil return end
    pl.lpchk = pl.lpchk + 1
    local name = rwplayer.getrandomname()

    local plys = player.GetAll();
    for i = 1, #plys do
    	if plys[i] == pl then continue; end
    	if plys[i]:getname() == name then randomname.check(pl, pl.lpchk) end
    end

    pl:setname( name )

end

function randomname.ongetname(pl,name,exists)
    if exists && lp.chk then
        randomname.check( pl, pl.lpchk )
    end
end
hook.Add("rwplayer.ongetname","randomname.ongetname",randomname.ongetname);

function randomname.onsetname(pl,oldname,newname)
    if pl.lpchk then pl.lpchk = nil end
    oldname = oldname || pl:getname()
    local sid = pl:SteamID()
    success( oldname .. " (" .. sid .. ") randomly changed their name to " .. newname .. "." )
end
hook.Add("rwplayer.onsetname","randomname.ongetname",randomname.onrandomname);

cmd.add(randomname,"rn");