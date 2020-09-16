if !prompt.enabled then return; end
local netstring   = util.AddNetworkString;
local netstart    = net.Start;
local netsend     = net.Send;
local netreceive  = net.Receive;
local readuint    = net.ReadUInt;
local writeuint   = net.WriteUInt;
local plyall      = player.GetAll;
local tableremove = table.remove;
local tableinsert = table.insert;
local entbyidx    = ents.GetByIndex;

netstring("prompt.send");
netstring("prompt.reply");
PROMPTDATA={};
PROMPTS={};

function prompt.send(name,netdata,from,to)
	local id=prompt[name];
	assert(id,"Invalid Prompt: "..name);
	local data=prompt[id];
	local fromid=0;
	if IsValid(from) then fromid=from:SteamID(); end
	if !PROMPTS[id] then PROMPTS[id]={}; end
	if data.svlimit then fromid=0; end
	if !PROMPTS[id][fromid] then PROMPTS[id][fromid]=0; end
	if data.svlimit&&PROMPTS[id][fromid]==data.svlimit then
		err("There can only be "..data.svlimit.." active "..name.."(s).",from);
		return false;
	end
	if data.cllimit&&PROMPTS[id][fromid]==data.cllimit then
		err("You can only have "..data.cllimit.." active "..name.."(s).",from);
		return false;
	end
	local idx = #PROMPTDATA+1;
	PROMPTDATA[idx] = {id,{}}
	wait.now(data.timeout,function()
		data.ontimeout(netdata,PROMPTDATA[idx][2]);
		PROMPTDATA[idx]=nil;
		PROMPTS[id][fromid]=PROMPTS[id][fromid]-1; // dec owned prompts.
		if PROMPTS[id][fromid]<0 then PROMPTS[id][fromid]=0; end
	end);
	netstart("prompt.send");
	writeuint(id,prompt.bits);
	writeuint(idx,8); --0-255
	data.send(netdata,from);
	netsend(to||plyall());
	PROMPTS[id][fromid]=PROMPTS[id][fromid]+1; // inc owned prompts.
end

function prompt.onreply()
	local idx     = readuint(7);
	local data    = PROMPTDATA[idx];
	local _prompt = prompt[data[1]];
	_prompt.onreply(data[2]);
end
netreceive("prompt.reply",prompt.onreply);