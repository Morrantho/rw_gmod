if !perk.enabled then return; end
local PERK       = {};
PERK.tree        = "neutral";
PERK.name        = "muffle";
PERK.description = "your footsteps no longer make sound.";
PERK.cost        = 1;
PERK.tiers       = 1;
PERK.multiplier  = 1;
PERK.exec        = function(p,pos,foot,snd,vol,rf)

end
perk.register(PERK);