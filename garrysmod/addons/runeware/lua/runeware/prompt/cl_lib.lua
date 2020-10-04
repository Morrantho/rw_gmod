if !prompt.enabled then return; end
local netstart    = net.Start;
local netsend     = net.SendToServer;
local netreceive=net.Receive;
local readuint=net.ReadUInt;
local writeuint=net.WriteUInt;
local hookadd=hook.Add;
local vguicreate=vgui.Create;
local tableremove=table.remove;
local localplayer=LocalPlayer;
local scrw,scrh=ScrW,ScrH;
prompt.prompts=prompt.prompts||{};

function prompt.colorize(netdata,pnl)
	local name=localplayer():getname():lower();
	for i=1,#netdata do
		local data=netdata[i];
		if type(data)!="string" then continue; end
		data=data:lower();
		if data:find("want") then
			pnl.nav.Paint=function(s,w,h)
				surface.SetDrawColor(color.get("blue"));
				surface.DrawRect(0,0,w,h);
			end
		end
		if data:find("warrant") then
			pnl.nav.Paint=function(s,w,h)
				surface.SetDrawColor(color.get("red"));
				surface.DrawRect(0,0,w,h);
			end
		end
	end
end

function prompt.enqueue(_prompt,netdata,svidx)
	local pnl      = vguicreate(_prompt.pnl);
	pnl.svidx      = svidx;
	pnl.idx        = #prompt.prompts+1;
	pnl.promptname = _prompt.name;
	pnl.promptid   = prompt[_prompt.name];
	prompt.prompts[pnl.idx] = pnl;
	assert(_prompt.oncreate,"Missing Prompt OnCreate callback.");
	_prompt.oncreate(pnl,netdata);
	local sw,sh = scrw(),scrh();
	local w,h   = pnl:GetSize();
	local x,y   = (pnl.idx-1)*w,sh-h;
	pnl:SetPos(sw,y);
	pnl:MoveTo(x,y,.25,0,-1,nil);
	prompt.colorize(netdata,pnl);
	return pnl;
end

function prompt.dequeue(pnl)
	if !IsValid(pnl) then return; end
	pnl:AlphaTo(0,.25,0,function()
		tableremove(prompt.prompts,pnl.idx);
		pnl:Remove();
		for i=1,#prompt.prompts do
			local pnl = prompt.prompts[i];
			local sw,sh = scrw(),scrh();
			local w,h = pnl:GetSize();
			local x,y = (i-1)*w,sh-h;
			pnl.idx = i;
			pnl:MoveTo(x,y,.25,0,-1,nil);
		end
	end);
end

function prompt.new(_prompt,netdata,svidx)
	local pnl = prompt.enqueue(_prompt,netdata,svidx);
	local promptalias = _prompt.name.."_"..pnl.idx;
	wait.start(promptalias,_prompt.timeout,1,function()
		prompt.dequeue(pnl);
	end);
end

function prompt.receive()
	local promptid = readuint(prompt.bits);
	local svidx    = readuint(8);
	local _prompt  = prompt[promptid];
	local netdata  = _prompt.receive();
	prompt.new(_prompt,netdata,svidx);
end
netreceive("prompt.send",prompt.receive);

function prompt.reply(pnl,netdata)
	local promptid = pnl.promptid;
	local _prompt  = prompt[promptid];
	netstart("prompt.reply");
	writeuint(pnl.svidx,7);
	_prompt.reply(netdata);
	netsend();
end