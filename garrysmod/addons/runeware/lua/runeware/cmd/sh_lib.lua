local cmdadd=concommand.Add;
local hookrun=hook.Run;
cmd=cmd||{};
cmd.dbg=cmd.dbg||false;
cmd.enabled=cmd.enabled||true;
if !cmd.enabled then return; end

function cmd.help(CMD,pl,txt)
	if txt then txt = txt.."\n"; else txt = ""; end
	txt = txt.."Usage: "..CMD.usage.."\n";
	txt = txt.."Description: "..CMD.description;
	err(txt,pl);
end

function cmd.haspower(CMD,pl)
	-- if pl:isconsole() then return true; end
	if pl:getpower() < CMD.power then
		cmd.help(CMD,pl,"You don't have the power to issue this command.");
		return false;
	end
	return true;
end

function cmd.cantarget(CMD,pl,args)
	for i=1,#args do
		local tgt = findplayer(args[i]);
		if IsValid(tgt) && tgt:IsPlayer() then
			if pl == tgt then continue; end
			if pl:getpower() < tgt:getpower() then
				cmd.help(CMD,pl,tgt:getname().." has higher immunity than you.");
				return false;
			end
		end
	end
	return true;
end
-- plz dont bypass power checks, the whole point
-- is to ensure lower powers cannot execute cmds
-- on higher powers.
function cmd.add(CMD,...)
	local aliases = {...};
	for i=0,#aliases do
		local alias = aliases[i];
		if !alias then alias = CMD.name; end
		-- // I moved this from the top of the func so now it'll add aliases properly. - Leg
		cmd[alias] = CMD;
		cmdadd("rw_"..alias,function(pl,_,args,argstr)
			if !cmd.haspower(CMD,pl) then return; end
			args = argstr:Split(" "); -- regular args dont work for steamids, etc.
			-- if !cmd.cantarget(CMD,pl,args) then return; end
			CMD.run(pl,args,argstr);
			hookrun("cmd.run",alias,args,argstr);
		end,CMD.autocomplete,CMD.usage,CMD.flags);
		if cmd.dbg then
			print( "cmd:add: rw_" .. alias .. " " .. CMD.power );
		end
	end
end