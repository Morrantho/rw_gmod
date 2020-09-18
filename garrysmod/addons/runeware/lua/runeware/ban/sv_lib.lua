local hookadd=hook.Add;
local hookrun=hook.Run;
ban=ban||{};
ban.dbg=false;
ban.enabled=true;
if !ban.enabled then return; end
function ban.PlayerAuthed(pl)
	db.isbanned({pl:SteamID()},{pl},ban.onauthed);
end
hookadd("PlayerAuthed","ban.PlayerAuthed",ban.PlayerAuthed);

function ban.onauthed(data,args)
	if #data > 0 then
		if hookrun("ban.onauthed",data[1],args) then return; end
		local fmt  = "You we're banned by "..data[1].adminname.." ("..data[1].admin..") ";
		fmt = fmt.."for "..data[1].reason.." for "..data[1].duration.."(s)";	
		args[1]:Kick(fmt);
		success(fmt);
	end
end

function ban.oncheckbanned(data,args)
	local isbanned = #data > 0;
	if hookrun("ban.oncheckbanned",args,isbanned) then return; end
	local context = args[1];
	if context == "ban" && isbanned then
		err(data[1].playername.." ("..data[1].player..") is already banned.",args[2]);
	elseif context == "ban" && !isbanned then
		db.banplayer({args[3],args[2]:SteamID(),args[6],args[4].." "..args[5]},args,ban.onban);
	elseif context == "unban" && isbanned then
		db.unbanplayer({args[3]},args,ban.onunban);
	elseif context == "unban" && !isbanned then
		err("("..args[3]..") is not banned.",args[2]);
	end
end

function ban.onplayerexists(data,args)
	local exists = #data > 0;
	if hookrun("ban.onplayerexists",args,exists) then return; end
	if exists then
		db.isbanned({args[3]},args,ban.oncheckbanned);
	else
		err("Non-Existant Player: "..args[3],args[2]);
	end
end

function ban.banplayer(admin,sid,dur,unit,rsn)
	local tgt = findplayer(sid);
	if IsValid(tgt) then
		local params = {sid,admin:SteamID(),rsn,dur.." "..unit};
		db.banplayer(params,{admin,sid,dur,unit,rsn,tgt},ban.onban);
	else
		db.getplayer({sid},{"ban",admin,sid,dur,unit,rsn},ban.onplayerexists);
	end
end

function ban.onban(data,args)
	if hookrun("ban.onban",data[1],args) then return; end
	local fmt = data[1].adminname.." ("..data[1].admin..")";
	fmt = fmt.." banned "..data[1].playername.." ("..data[1].player..") for";
	fmt = fmt.." "..data[1].reason.." for "..data[1].duration.."(s).";
	err(fmt);

	local tgt = args[6];
	if type(tgt) == "Player" && IsValid(tgt) then 
		fmt = "You we're banned by "..data[1].adminname.." ("..data[1].admin..") ";
		fmt = fmt.."for "..data[1].reason.." for "..data[1].duration.."(s)";
		tgt:Kick(fmt);
	end
end

function ban.unbanplayer(admin,sid)
	db.getplayer({sid},{"unban",admin,sid,dur,unit,rsn},ban.onplayerexists);
end

function ban.onunban(data,args)
	if hookrun("ban.onunban",args) then return; end
	local fmt = data[1].adminname.." ("..data[1].admin..")";
	fmt = fmt.." unbanned "..data[1].playername.." ("..data[1].player..").";
	success(fmt);
end