if !cmd.enabled then return; end

local CMD       = {};
CMD.name        = "size";
CMD.usage       = "size <steamid / name> <number>";
CMD.description = "Sets a player's size.";
CMD.power       = role.admin;

local sizes =
{
    {
        jmp = function(size) return 50 * ( math.pow( size, 2 ) ) + 150 end,
        spd = function(size) return 120 * size + 120 end,
        min = 0.009,
        max = 0.98
    },
     {
         jmp = function(size) return 200 end,
        spd = function(size) return 240; end,
        min = 0.99,
        max = 1.01
    },
     {
         jmp = function(size) return 3.3 * ( math.pow( size, 2 ) ) + 200 end,
        spd = function(size) return 76 * size + 240 end,
        min = 1.02,
        max = 10.01
    }
}



function getrange(size)
    for i = 1 , #sizes do
        local data = sizes[i];
        if size > data.min && size < data.max then return data; end
    end
end

function CMD.run(ply,args,argstr)

    if #args < 2 || args[1] == "" then cmd.help(CMD,ply); return; end
    local trg = findplayer(args[1]);
    local size = tonumber(args[2])
    if !isnumber(size) then
        err( "Invalid size.",ply)
        return;
    end
    local size = math.Clamp( size, 0.01, 10 )

    if !trg then err( "The player " .. args[1] .. " does not exist.",ply) return end

    local data = getrange(size);

    if !data then
        cmd.help(CMD,pl,"Size must be between 0-10.");
        return;
    end

    if trg:IsPlayer() && isnumber( size ) then
        local stepSize          = 18 * size
        local jumpSize = data.jmp(size);
        local speedSize = data.spd(size);
        trg:SetViewOffset( Vector(0, 0, 64 * size * 0.9 ) )
        trg:SetCurrentViewOffset( Vector(0, 0, 64 * size ) )
        trg:SetViewOffsetDucked( Vector(0, 0, 64 * size * 0.4375 ) )
        trg:SetRunSpeed( speedSize )
        trg:SetWalkSpeed( 2*speedSize / 3 )
        trg:SetModelScale( size, 0 )
        trg:SetStepSize( stepSize )
        trg:SetJumpPower( jumpSize )
        success( trg:getname() .. "'s size has been set to x" .. size, ply )
    elseif size < 0.001 || size > 10 then
        err( "Size must be between 0.01 and 10." ,ply );
        return
    else
        err( "Invalid size." , ply )
        return
    end

end

cmd.add(CMD);