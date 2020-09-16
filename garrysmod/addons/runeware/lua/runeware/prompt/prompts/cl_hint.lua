if !prompt.enabled then return; end
local readuint=net.ReadUInt;
local readstr=net.ReadString;
local floor=math.floor;
local entbyidx=ents.GetByIndex;
local localplayer=LocalPlayer;

local PROMPT={};
PROMPT.name="hint";
PROMPT.pnl="cl_hint";
PROMPT.timeout=3;

function PROMPT.receive()
	return {readstr(),readstr()};
end

function PROMPT.reply() end

function PROMPT.oncreate(pnl,netdata)
	local title=netdata[1];
	local body=netdata[2];
	local alias="hint_"..pnl.idx;
	pnl.text:SetText(body);
	pnl.text:SizeToContents();
	pnl.title.Think=function(lbl)
		local left=floor(wait.timeleft(alias)||0);
		lbl:SetText(title..": "..left);
	end
end
prompt.register(PROMPT);