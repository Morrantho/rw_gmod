rwentity=rwentity||{};
rwentity.dbg=rwentity.dbg||false;
rwentity.enabled=rwentity.enabled||true;
if !rwentity.enabled then return; end
local ent = FindMetaTable("Entity");

function ent:getowner()
	return self.owner;
end

function ent:isconsole()
	return !IsValid(self) && self:EntIndex() == 0;
end