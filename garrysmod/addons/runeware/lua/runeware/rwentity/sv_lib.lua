local hookadd=hook.Add;

if !rwentity.enabled then return; end
local ent = FindMetaTable("Entity");

function ent:setowner(pl)
	admin.ownent(pl,self);
end