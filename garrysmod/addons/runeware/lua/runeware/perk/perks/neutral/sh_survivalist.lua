if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "neutral";
PERK.name        = "survivalist";
PERK.description = "You starve %d% slower.";
PERK.cost        = 1;
PERK.tiers       = 3;
PERK.multiplier  = 4;
PERK.exec        = function(p)

end
perk.register(PERK);