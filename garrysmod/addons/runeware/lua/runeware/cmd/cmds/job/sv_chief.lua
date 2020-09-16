if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "chief";
CMD.usage       = "chief";
CMD.description = "Run for chief.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	local chief=gov.getchief();
	if IsValid(chief)&&chief:IsPlayer() then
		cmd.help(CMD,pl,"There is already a chief.");
		return;
	end
	if pl:ischief() then
		cmd.help(CMD,pl,"You are already the police chief.");
		return;
	end
	prompt.send("chief nomination",{pl:SteamID()},nil,nil);
end
cmd.add(CMD);