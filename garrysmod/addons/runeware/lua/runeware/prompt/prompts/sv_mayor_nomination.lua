if !prompt.enabled then return; end
local readstr=net.ReadString;

local PROMPT={};
PROMPT.name="mayor nomination";
PROMPT.timeout=10;
PROMPT.svlimit=1;

function PROMPT.send(netdata)

end

function PROMPT.ontimeout(netdata,candidates)
	if #candidates <= 0 then
		err("There were no candidates to run for mayor.");
		return;
	end
	prompt.send("mayor election",candidates||{},nil,nil);
end

function PROMPT.onreply(results)
	results[#results+1] = readstr();
end
prompt.register(PROMPT);