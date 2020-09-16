if !prompt.enabled then return; end
local readstr   = net.ReadString;
local writestr  = net.WriteString;
local writeuint = net.WriteUInt;
local push      = table.insert;

local PROMPT    = {};
PROMPT.name     = "mayor election";
PROMPT.timeout  = 10;
PROMPT.svlimit  = 1;

function PROMPT.send(netdata)
	local len = #netdata;
	writeuint(len,7); -- #of candidates
	for i=1,len do
		writestr(netdata[i]);
	end
end

local function formatvotes(votes)
	local fmt={};
	for a,b in pairs(votes) do
		if !fmt[b] then fmt[b]={}; end
		push(fmt[b],a);
	end
	return fmt;
end

function PROMPT.ontimeout(netdata,votes)
	votes=formatvotes(votes||{});
	local ties=votes[#votes]||{};
	if #ties==1 then
		local winner=findplayer(ties[1]);
		success(winner:getname().." won the election.");
		winner:setjob("mayor");
	elseif #ties>1 then
		err("There was a "..#ties.." way tie for mayor.");
		prompt.send("mayor election",ties,nil,nil);
	else
		err("Noone voted for a mayor.");
	end
end

-- keys = candidate steam ids, values are their # of votes.
function PROMPT.onreply(votes)
	local sid = readstr();
	if !votes[sid] then votes[sid] = 0; end
	votes[sid] = votes[sid]+1;
end
prompt.register(PROMPT);