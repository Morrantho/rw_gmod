local findmeta=FindMetaTable;
local pl=findmeta("Player");
gov=gov||{};
gov.dbg=gov.dbg||false;
gov.enabled=gov.enabled||true;
if !gov.enabled then return; end
function gov.getmayor()
	return job.getplayers("mayor")[1];
end

function gov.getchief()
	return job.getplayers("chief")[1];
end

function gov.getcops()
	return job.getplayers("cop");
end

function gov.getgov()
	return job.getteamplayers("civil protection");
end

function gov.isarrested(pl)
	return pl:hasstatus("arrested");
end

function gov.iswanted(pl)
	return pl:hasstatus("wanted");
end

function gov.iswarranted(pl)
	return pl:hasstatus("warranted");
end

function pl:isarrested()
	return gov.isarrested(self);
end

function pl:iswanted()
	return gov.iswanted(self);
end

function pl:iswarranted()
	return gov.iswarranted(self);
end