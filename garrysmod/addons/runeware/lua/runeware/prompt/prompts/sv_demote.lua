if !prompt.enabled then return; end
local writeuint  = net.WriteUInt;
local writestr   = net.WriteString;
local readbit    = net.ReadBit;
local entbyindex = ents.GetByIndex;

local PROMPT    = {};
PROMPT.name     = "demote";
PROMPT.timeout  = 5;
PROMPT.cllimit  = 1;

function PROMPT.send(netdata)
	writestr(netdata[1]); -- demoter
	writestr(netdata[2]); -- demotee
	writestr(netdata[3]); -- reason
end

function PROMPT.ontimeout(netdata,results)
	local pl  = findplayer(netdata[1]);
	local tgt = findplayer(netdata[2]);
	local rsn = netdata[3];
	local no  = results[1]||0;
	local yes = results[2]||0;
	local plname,tgtname = pl:getname(),tgt:getname();
	if yes > no then
		tgt:setjob("citizen");
		success(tgtname.." was demoted by "..plname.." for "..rsn..".");
	else
		success(tgtname.." was not demoted.");
	end
end

function PROMPT.onreply(results)
	local decision = readbit();
	if !results[decision] then results[decision] = 0; end
	results[decision] = results[decision]+1;
end
prompt.register(PROMPT);