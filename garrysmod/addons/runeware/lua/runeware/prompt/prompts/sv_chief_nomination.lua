if !prompt.enabled then return; end
local readstr=net.ReadString;
local writestr=net.WriteString;
local readbit=net.ReadBit;
local plyall=player.GetAll;

local PROMPT={};
PROMPT.name="chief nomination";
PROMPT.timeout=10;
PROMPT.svlimit=1;

function PROMPT.send(netdata)
	writestr(netdata[1]);
end

function PROMPT.ontimeout(netdata,votes)
	local chief=findplayer(netdata[1]);
	local name=chief:getname();
	if !votes[1]||votes[1]<(#plyall()/2) then 
		err(name.." was not elected Chief.");
		return;
	end
	chief:setjob("chief");
	success(name.." was elected Chief.");
end

function PROMPT.onreply(results)
	local decision=readbit();
	if !results[decision] then results[decision]=0; end
	results[decision]=results[decision]+1;
end
prompt.register(PROMPT);