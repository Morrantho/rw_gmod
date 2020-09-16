local netstr=util.AddNetworkString;
local netstart=net.Start;
local netsend=net.Send;
local writestr=net.WriteString;
local plyall=player.GetAll;
local findmeta=FindMetaTable;
local print=print;

local pl=findmeta("Player");
netstr("err");
netstr("success");

function success(txt,to)
	if to&&to:isconsole() then
		print(txt);
		return;
	end
	netstart("success");
	writestr(txt);
	netsend(to||plyall());
end

function err(txt,to)
	if to&&to:isconsole() then 
		print(txt);
		return;
	end
	netstart("err");
	writestr(txt);
	netsend(to||plyall());
end