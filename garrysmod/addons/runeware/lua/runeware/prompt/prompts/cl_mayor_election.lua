if !prompt.enabled then return; end
local readuint = net.ReadUInt;
local readstr  = net.ReadString;
local writebit = net.WriteBit;
local writestr = net.WriteString;
local floor    = math.floor;
local entbyidx = ents.GetByIndex;
local plbysid  = player.GetBySteamID;
local localplayer = LocalPlayer;

local PROMPT    = {};
PROMPT.name     = "mayor election";
PROMPT.pnl      = "cl_form";
PROMPT.timeout  = 10;

function PROMPT.receive()
	local len = readuint(7);
	local res = {};
	for i=1,len do res[#res+1] = readstr(); end
	return res;
end

function PROMPT.reply(sid)
	writestr(sid);
end

function PROMPT.oncreate(pnl,netdata)
	local promptalias = "mayor election_"..pnl.idx;
	pnl.title.Think = function(lbl)
		local left = floor(wait.timeleft(promptalias)||0);
		lbl:SetText("Mayor Election: "..left);
	end
	for i=1,#netdata do
		local sid  = netdata[i];
		local name = plbysid(sid):getname();
		pnl:add(name,function()
			prompt.reply(pnl,sid);
			prompt.dequeue(pnl);
		end);
	end
end
prompt.register(PROMPT);