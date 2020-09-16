if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "mayor";
CMD.usage       = "mayor";
CMD.description = "Run for mayor.";
CMD.power       = role.member;

function CMD.run(pl,args,argstr)
	local mayor=gov.getmayor();
	if IsValid(mayor)&&mayor:IsPlayer() then
		cmd.help(CMD,pl,"There is already a mayor.");
		return;
	end
	if pl:ismayor() then
		cmd.help(CMD,pl,"You are already the mayor.");
		return;
	end
	prompt.send("mayor nomination",{},nil,nil);
end
cmd.add(CMD);