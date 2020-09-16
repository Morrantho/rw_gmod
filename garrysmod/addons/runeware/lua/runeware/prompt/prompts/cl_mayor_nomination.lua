if !prompt.enabled then return; end
local readuint = net.ReadUInt;
local readstr  = net.ReadString;
local writebit = net.WriteBit;
local writestr = net.WriteString;
local floor    = math.floor;
local entbyidx = ents.GetByIndex;
local localplayer = LocalPlayer;

local PROMPT    = {};
PROMPT.name     = "mayor nomination";
PROMPT.pnl      = "cl_yesno";
PROMPT.timeout  = 10;

function PROMPT.receive()
	return {};
end

function PROMPT.reply(sid)
	writestr(sid);
end

function PROMPT.oncreate(pnl,netdata)
	local promptalias = "mayor nomination_"..pnl.idx;
	local fmt         = "Would you like to run for mayor?";
	pnl.text:SetText(fmt);
	pnl.text:SizeToContents();
	pnl.title.Think = function(lbl)
		local left = floor(wait.timeleft(promptalias)||0);
		lbl:SetText("Run for mayor: "..left);
	end
	pnl.onyes = function()
		prompt.reply(pnl,localplayer():SteamID());
	end
end
prompt.register(PROMPT);