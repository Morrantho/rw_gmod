if !db.enabled then return; end
local hookadd     = hook.Add;
local netstart    = net.Start;
local writeuint   = net.WriteUInt;
local netsend     = net.SendToServer;
local hookremove  = hook.Remove;
local localplayer = LocalPlayer;

function db.await()
	local lp = localplayer();
	if !IsValid(lp) then return; end
	local uid = lp:UserID();
	if !uid then return; end
	hookremove("Tick","db.await");
	ui.load();
	netstart("db.await");
	writeuint(uid,7); -- 0-127
	netsend();
end
hookadd("Tick","db.await",db.await);