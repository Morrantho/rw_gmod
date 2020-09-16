if !prompt.enabled then return; end
local readuint = net.ReadUInt;
local readstr  = net.ReadString;
local writebit = net.WriteBit;
local writestr=net.WriteString;
local readstr=net.ReadString;
local writebit=net.WriteBit;
local floor=math.floor;
local entbyidx=ents.GetByIndex;
local localplayer=LocalPlayer;

local PROMPT    = {};
PROMPT.name     = "chief nomination";
PROMPT.pnl      = "cl_yesno";
PROMPT.timeout  = 10;

function PROMPT.receive()
	return {readstr()};
end

function PROMPT.reply(decision)
	writebit(decision);
end

function PROMPT.oncreate(pnl,netdata)
	local chief=findplayer(netdata[1]);
	local promptalias = "chief nomination_"..pnl.idx;
	local fmt         = "Elect "..chief:getname().." as Chief?";
	pnl.text:SetText(fmt);
	pnl.text:SizeToContents();
	pnl.title.Think = function(lbl)
		local left = floor(wait.timeleft(promptalias)||0);
		lbl:SetText("Chief Election: "..left);
	end
	pnl.onyes=function()
		prompt.reply(pnl,1);
	end
end
prompt.register(PROMPT);