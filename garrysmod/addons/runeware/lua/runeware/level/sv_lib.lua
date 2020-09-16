if !level.enabled then return; end
local hookadd=hook.Add;
local hookrun=hook.Run;
local writeuint=net.WriteUInt;
local pl=FindMetaTable("Player");

function level.onsetlevel(data,args)
	local pl=args[1];
	local lvl=args[2];
	cache.write("level","set",pl,lvl,pl);
end

function level.onsetxp(data,args)
	local pl=args[1];
	local xp=args[2];
	cache.write("xp","set",pl,xp,pl);
end

function level.shouldlevel(pl,addedxp)
	local lvl=pl:getlevel();
	local xp=pl:getxp();
	return xp+addedxp>(lvl+3)*25;
end

function level.getbleedxp(pl,addedxp)
	local lvl=pl:getlevel();
	local xp=pl:getxp();
	return (xp+addedxp)-(lvl+3)*25;
end

function level.ismaxlevel(pl)
	return pl:getlevel()>=level.maxlevel;
end

function level.setlevel(pl,lvl)
	local sid=pl:SteamID();
	local params={sid,lvl};
	local args={pl,lvl};
	db.setlevel(params,args,level.onsetlevel);
end

function level.setxp(pl,xp)
	local sid=pl:SteamID();
	local params={sid,xp};
	local args={pl,xp};
	db.setxp(params,args,level.onsetxp);
end

function level.addlevel(pl,lvls)
	local newlvl=pl:getlevel()+lvls;
	pl:setlevel(newlvl);
	hookrun("level.onlevelgained",pl,newlvl,lvls); -- newlvl,# of levels
end

function level.addxp(pl,addedxp)
	if pl:ismaxlevel() then return; end
	local xp=pl:getxp();
	if pl:shouldlevel(addedxp) then
		xp=pl:getbleedxp(addedxp);
		pl:addlevel(1);
	else
		xp=xp+addedxp;
	end
	pl:setxp(xp);
	hookrun("level.onxpgained",pl,addedxp,xp); -- added, total
	success(pl,"You gained "..addedxp.." xp.");
end

function level.loadplayer(data,pl)
	level.onsetlevel(nil,{pl,data.level});
	level.onsetxp(nil,{pl,data.xp});
end
hookadd("db.loadplayer","level.loadplayer",level.loadplayer);

function pl:setlevel(lvl)
	level.setlevel(self,lvl);
end

function pl:setxp(xp)
	level.setxp(self,xp);
end

function pl:shouldlevel(addedxp)
	return level.shouldlevel(self,addedxp);
end

function pl:getbleedxp(addedxp)
	return level.getbleedxp(self,addedxp);
end

function pl:addlevel(lvls)
	level.addlevel(self,lvls);
end

function pl:addxp(xp)
	level.addxp(self,xp);
end

cache.register({
	name="level",
	set=function(varid,ent,cached,level)
		cached[varid]=level;
		writeuint(level,8); -- 0-255
	end
});

cache.register({
	name="xp",
	set=function(varid,ent,cached,xp)
		cached[varid]=xp;
		writeuint(xp,11); -- 0-2047
	end
});