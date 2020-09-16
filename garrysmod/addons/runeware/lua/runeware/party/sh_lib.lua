party=party||{};
party.data=party.data||{};
party.class=party.class||{};
party.class.name=party.class.name||"New Party";
party.class.limit=party.class.limit||8;
party.class.members=party.class.members||{};
party.dbg=party.dbg||false;
party.enabled=party.enabled||true;
if !party.enabled then return; end
-- local TYPES = { -- moved to zcfg/sh_party.lua
--     string = true,
--     int = true,
--     float = true,
--     bool = true
-- }

function party.addnwvar( name, type, size )
    assert(party.nettypes[type], "Invalid nwvar type (see party.nettypes table for valid types)")
    if type == int then 
        size = size or 8
        assert(isnumber(size), "Nwvar type integer requires a number for size")
    end

    local nwvar = {
        name = name,
        type = type,
        size = size
    }

    local i = #party.nwvar + 1
    party.nwvar[i] = nwvar
    party.nwvar[name] = i
end

function party.getnwvar( name )
    if isnumber(name) then
        return party.nwvar[name] or false
    end

    return party.nwvar[party.nwvar[name]] or false
end

function party.createparty(  )
    local p = party()
end