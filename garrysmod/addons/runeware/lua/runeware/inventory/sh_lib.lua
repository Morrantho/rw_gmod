local pl=FindMetaTable("Entity");
inventory=inventory||{};
inventory.dbg=inventory.dbg||false;
inventory.enabled=inventory.enabled||true;
if !inventory.enabled then return; end
function pl:getinventory()
	return cache.get(self,"inventory");
end

function pl:getbag(bagidx)
	local maxbags=inventory.maxbags+1;
	local inrange=bagidx>0&&bagidx<maxbags;
	assert(inrange,"Bag index must be between 1-"..maxbags);
	local inv=self:getinventory();
	return inv[idx];
end