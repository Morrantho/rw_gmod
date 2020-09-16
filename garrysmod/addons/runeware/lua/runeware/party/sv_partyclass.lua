if !party.enabled then return; end
local globalmeta = {}
local index = {}
local meta = { __index = index }
setmetatable(party, globalmeta)

util.AddNetworkString("party.set")

function index:setnwvar( name, val )
    local var = party.getnwvar(name) 

    assert(var, "Unregistered nwvar")
    local write = net["Write"..var.name[1]:upper()..var.name:sub(2)]

    assert(write, "Unknown write function")

end

function globalmeta:__call()
    local obj = table.Copy(self.class)
    setmetatable(obj, meta)
    return obj
end