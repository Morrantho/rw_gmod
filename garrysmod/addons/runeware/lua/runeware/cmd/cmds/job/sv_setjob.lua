if !cmd.enabled then return; end
local tableremove = table.remove;
local tableconcat = table.concat;
local CMD       = {};
CMD.name        = "setjob";
CMD.usage       = "setjob <player> <jobname>";
CMD.description = "Set a player's job.";
CMD.power       = role.admin;

function CMD.run(pl,args,argstr)
	if #args < 1 then 
		cmd.help(CMD,pl);
		return;
	end
	local tgt = findplayer(args[1]);
	if !IsValid(tgt) then
		cmd.help(CMD,pl,"Invalid Player: "..args[1]);
		return;
	end
	tableremove(args,1);
	local jobname = tableconcat(args," ")
	local jobid   = job[jobname];
	if !jobid then
		cmd.help(CMD,pl,"Invalid Job: "..jobname);
		return;
	end
	tgt:setjob(jobname);
	success(pl:getname().." set "..tgt:getname().."'s job to "..jobname);
end
cmd.add(CMD);