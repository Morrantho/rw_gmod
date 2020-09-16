if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "neutral";
PERK.name        = "armorer";
PERK.description = "You gain the ability to craft armors.";
PERK.cost        = 1;
PERK.tiers       = 1;
PERK.multiplier  = 1;
PERK.exec        = function(pl)

end
perk.register(PERK);