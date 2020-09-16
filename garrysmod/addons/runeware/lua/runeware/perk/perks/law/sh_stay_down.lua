if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "law";
PERK.name        = "stay down";
PERK.description = "Your taser keeps victims knocked out for %d extra seconds";
PERK.cost        = 1;
PERK.tiers       = 1;
PERK.multiplier  = 1;
PERK.exec        = function(p)

end
perk.register(PERK);