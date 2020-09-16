if !cmd.enabled then return; end
local hookadd=hook.Add;

function cmd.playersay(pl,txt,tm)
	if (txt[1]=="!"||txt[1]=="/")&&cmd[txt:Split(" ")[1]:sub(2,#txt)] then
		pl:ConCommand("rw_"..txt:sub(2,#txt));
		return "";
	end
	return txt;
end
hookadd("PlayerSay","cmd.playersay",cmd.playersay);