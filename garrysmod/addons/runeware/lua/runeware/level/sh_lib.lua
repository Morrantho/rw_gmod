local pl=FindMetaTable("Player");
level=level||{};
level.dbg=level.dbg||false;
level.enabled=level.enabled||true;
if !level.enabled then return; end
function pl:getlevel()
	return cache.get(self,"level")||1;
end

function pl:getxp()
	return cache.get(self,"xp")||0;
end

function pl:getrequiredxp()
	return (self:getlevel()+3)*25;
end