if !prompt.enabled then return; end
local readstr=net.ReadString;
local writestr=net.WriteString;

local PROMPT={};
PROMPT.name="hint";
PROMPT.timeout=3;

function PROMPT.send(netdata)
	writestr(netdata[1]);--title
	writestr(netdata[2]);--body
end

function PROMPT.ontimeout(netdata,results)
	
end

function PROMPT.onreply(results)
	
end
prompt.register(PROMPT);