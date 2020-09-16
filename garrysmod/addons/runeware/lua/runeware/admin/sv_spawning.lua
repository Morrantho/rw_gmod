if !admin.enabled then return; end
local hookadd=hook.Add;

function admin.CanUndo(pl,data)
	local ents=data.Entities;
	if !ents then return false; end -- im confused if this ever happens
	for i=1,#ents do ents[i]:setowner(nil); end
	return true;
end
hookadd("CanUndo","admin.CanUndo",admin.CanUndo);

function admin.PlayerSpawnProp(pl,mdl)
	if !admin.handleblacklisted(pl,mdl) then return false; end
	if !admin.handleproplimit(pl) then return false; end
	if admin.isspawndelayed(pl) then return false; end
	return true;
end
hookadd("PlayerSpawnProp","admin.PlayerSpawnProp",admin.PlayerSpawnProp);

function admin.PlayerSpawnedProp(pl,mdl,ent)
	admin.ghostent(ent,false,20,admin.propghostmaterial,admin.propghostcolor);
	ent:setowner(pl);
end
hookadd("PlayerSpawnedProp","admin.PlayerSpawnedProp",admin.PlayerSpawnedProp);

function admin.PlayerSpawnEffect(pl,mdl)
	return true;
end
hookadd("PlayerSpawnEffect","admin.PlayerSpawnEffect",admin.PlayerSpawnEffect);

function admin.PlayerSpawnedEffect(pl,mdl,ent)
	admin.ghostent(ent,false,20,admin.propghostmaterial,admin.propghostcolor);
	ent:setowner(pl);
end
hookadd("PlayerSpawnedEffect","admin.PlayerSpawnedEffect",admin.PlayerSpawnedEffect);

function admin.PlayerSpawnNPC(pl,npctype,wep)
	return true;
end
hookadd("PlayerSpawnNPC","admin.PlayerSpawnNPC",admin.PlayerSpawnNPC);

function admin.PlayerSpawnedNPC(pl,ent)

end
hookadd("PlayerSpawnedNPC","admin.PlayerSpawnedNPC",admin.PlayerSpawnedNPC);

function admin.PlayerSpawnRagdoll(pl,mdl)
	return true;
end
hookadd("PlayerSpawnRagdoll","admin.PlayerSpawnRagdoll",admin.PlayerSpawnRagdoll);

function admin.PlayerSpawnedRagdoll(pl,mdl,ent)

end
hookadd("PlayerSpawnedRagdoll","admin.PlayerSpawnedRagdoll",admin.PlayerSpawnedRagdoll);

function admin.PlayerSpawnSENT(pl)
	return true;
end
hookadd("PlayerSpawnSENT","admin.PlayerSpawnSENT",admin.PlayerSpawnSENT);

function admin.PlayerSpawnedSENT()

end
hookadd("PlayerSpawnedSENT","admin.PlayerSpawnedSENT",admin.PlayerSpawnedSENT);

function admin.PlayerSpawnSWEP()
	return true;
end
hookadd("PlayerSpawnSWEP","admin.PlayerSpawnSWEP",admin.PlayerSpawnSWEP);

function admin.PlayerSpawnedSWEP()

end
hookadd("PlayerSpawnedSWEP","admin.PlayerSpawnedSWEP",admin.PlayerSpawnedSWEP);

function admin.PlayerSpawnVehicle()
	return false;
end
hookadd("PlayerSpawnVehicle","admin.PlayerSpawnVehicle",admin.PlayerSpawnVehicle);

function admin.PlayerSpawnedVehicle()

end
hookadd("PlayerSpawnedVehicle","admin.PlayerSpawnedVehicle",admin.PlayerSpawnedVehicle);