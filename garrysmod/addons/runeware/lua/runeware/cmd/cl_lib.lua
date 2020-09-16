if !cmd.enabled then return; end
local push    = table.insert;
local addtext = chat.AddText;
local getcol  = color.get;
local hookadd=hook.Add;

function cmd.onplayerchat(pl,txt,tm,ded)
	if (txt[1]=="!"||txt[1]=="/")&&cmd[txt:Split(" ")[1]:sub(2,#txt)] then
		pl:ConCommand("rw_"..txt:sub(2,#txt));
		return true;
	end
	local _job=pl:getjob();
	local col=_job.color||getcol("green");
	local info = {};
	if ded then push(info,getcol("red")); push(info,"[DEAD] "); end
	if tm then push(info,getcol("green")); push(info,"[TEAM] "); end
	if !ded && !tm then push(info,col); end
	push(info,pl:getname()||pl:Name());
	push(info,getcol("whitest"));
	push(info,": "..txt);
	addtext(unpack(info));
	return true;
end
hookadd("OnPlayerChat","cmd.onplayerchat",cmd.onplayerchat);