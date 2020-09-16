if !prompt.enabled then return; end
local readuint = net.ReadUInt;
local readstr  = net.ReadString;
local writebit = net.WriteBit;
local floor    = math.floor;
local entbyidx = ents.GetByIndex;

local PROMPT    = {};
PROMPT.name     = "demote";
PROMPT.pnl      = "cl_yesno";
PROMPT.timeout  = 5;

function PROMPT.receive()
	return
	{
		readstr(),
		readstr(),
		readstr(),
	};
end

function PROMPT.reply(decision)
	writebit(decision); -- yes/no
end

function PROMPT.oncreate(pnl,netdata)
	local promptalias = "demote_"..pnl.idx;
	local by,tgt      = findplayer(netdata[1]),findplayer(netdata[2]);
	local tgtname     = tgt:getname();
	local rsn         = netdata[3];
	local fmt         = "Demote "..tgtname.." for "..rsn.."?";
	pnl.onyes = function()
		prompt.reply(pnl,1);
	end
	pnl.onno = function()
		prompt.reply(pnl,0);
	end
	pnl.onclose = pnl.onno;
	pnl.text:SetText(fmt);
	pnl.text:SizeToContents();
	pnl.title.Think = function(lbl)
		local left = floor(wait.timeleft(promptalias)||0);
		lbl:SetText("Demote: "..left);
	end
end
prompt.register(PROMPT);