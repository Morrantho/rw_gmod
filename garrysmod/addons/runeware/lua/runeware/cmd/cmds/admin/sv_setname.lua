if !cmd.enabled then return; end

local match         = string.match;
local setname       = {};
setname.name        = "setname";
setname.usage       = "setname <name>";
setname.description = "Set your name.";
setname.power       = role.member;
setname.re          = "%w";

function setname.run(pl,args,argstr)
	if #args < 1 then 
		cmd.help(setname,pl); 
		return;
	end
	if argstr == pl:getname() then 
		cmd.help(setname,pl,"You've already chosen this name.");
		return;
	end
	local len = #argstr;
	if len < 3 || len > 32 then
		cmd.help(setname,pl,"Names must be between 3-32 characters.");
		return;
	end
	if !match(argstr,setname.re) then
		cmd.help(setname,pl,"Names can only contain characters A-Z, a-z, and 0-9.");
		return;
	end
	local plys = player.GetAll();
	for i=1,#plys do
		if !IsValid(plys[i]) then continue; end
		if plys[i] == pl then continue; end
		if plys[i]:getname() == argstr then
			cmd.help(setname,pl,"The name "..name.." is already taken.");
			return;
		end
	end
	pl:setname(argstr);
end

function setname.ongetname(pl,name,exists)
	if exists then
		cmd.help(setname,pl,"The name "..name.." is already taken.");
	end
end
hook.Add("rwplayer.ongetname","setname.ongetname",setname.ongetname);

function setname.onsetname(pl,oldname,newname)
	oldname = oldname || pl:getname();
	local sid = pl:SteamID();
	success(oldname.." ("..sid..") changed their name to "..newname..".");
end
hook.Add("rwplayer.onsetname","setname.ongetname",setname.onsetname);

cmd.add(setname);