if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "neutral";
PERK.name        = "iron stomach";
PERK.description = "Consumed food sates more.";
PERK.cost        = 1;
PERK.tiers       = 1;
PERK.multiplier  = 1;
PERK.exec        = function(p,e,amt)

end
perk.register(PERK);