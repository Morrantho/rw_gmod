if !admin.enabled then return; end
local hookadd=hook.Add;

function admin.PlayerNoClip(pl)
	return pl:Alive() && pl:IsAdmin();
end
hookadd("PlayerNoClip","admin.PlayerNoClip",admin.PlayerNoClip);

function admin.HandlePlayerNoClipping(pl,vel)
	--return false;
end
hookadd("PlayerNoClip","admin.HandlePlayerNoClipping",admin.HandlePlayerNoClipping);