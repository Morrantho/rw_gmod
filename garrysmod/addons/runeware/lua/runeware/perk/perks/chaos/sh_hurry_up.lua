if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "chaos";
PERK.name        = "hurry up";
PERK.description = "Reduce the mayor's grace time by %d second(s).";
PERK.cost        = 1;
PERK.tiers       = 4;
PERK.multiplier  = 1;
PERK.exec        = function()
end
perk.register(PERK);