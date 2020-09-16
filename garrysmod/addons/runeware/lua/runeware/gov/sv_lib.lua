if !gov.enabled then return; end
local writestr=net.WriteString;
local netstr=util.AddNetworkString;
local netstart=net.Start;
local netsend=net.Send;
local findmeta=FindMetaTable;
local hookrun=hook.Run;
local rand=math.random;
local pl=findmeta("Player");

function gov.want(cop,pl,rsn)
	if cop&&!cop:iscop() then
		err("Only Civil Protection can want players.",cop);
		return;
	end
	if cop&&pl:isgov() then
		err("Civil Protection cannot want other Civil Protection.",cop);
		return;
	end
	if cop&&pl:iswanted() then
		err(pl:getname().." is already wanted.",cop);
		return;
	end
	local fmt="";
	if cop then
		fmt=cop:getname().." wanted "..pl:getname().." for "..rsn;
	else
		fmt=pl:getname().." was autowanted for "..rsn;
	end
	prompt.send("hint",{"Wanted",fmt},nil,nil);
	pl:addstatus("wanted");
	hookrun("gov.want",cop,pl,rsn);
end

function gov.unwant(cop,pl)
	if cop&&!cop:iscop() then
		err("Only Civil Protection can unwant players.",cop);
		return;
	end
	if cop&&pl:isgov() then
		err("Civil Protection cannot unwant other Civil Protection.",cop);
		return;
	end
	if cop&&!pl:iswanted() then
		err(pl:getname().." is not wanted.",cop);
		return;
	end
	local fmt="";
	if cop then
		fmt=cop:getname().." unwanted "..pl:getname()..".";
	else
		fmt=pl:getname().." is no longer wanted.";
	end
	pl:removestatus("wanted");
	pl:removestatus("warranted");
	prompt.send("hint",{"Unwanted",fmt},nil,nil);
	hookrun("gov.unwant",cop,pl);
end

function gov.warrant(cop,pl,rsn)
	if cop&&!cop:iscop() then
		err("Only Civil Protection can warrant players.",cop);
		return;
	end
	if cop&&pl:isgov() then
		err("Civil Protection cannot warrant other Civil Protection.",cop);
		return;
	end
	if cop&&pl:iswarranted() then
		err(pl:getname().." is already warranted.",cop);
		return;
	end
	if cop&&!pl:iswanted() then
		err(pl:getname().." must be wanted before being warranted.",cop);
		return;
	end	
	local fmt="";
	if cop then
		fmt=cop:getname().." warranted "..pl:getname().." for "..rsn;
	else
		fmt=pl:getname().." was autowarranted for "..rsn;
	end
	prompt.send("hint",{"Warrant",fmt},nil,nil);
	pl:addstatus("warranted");
	hookrun("gov.warrant",cop,pl,rsn);
end

function gov.unwarrant(cop,pl)
	if cop&&!cop:iscop() then
		err("Only Civil Protection can unwarrant players.",cop);
		return;
	end
	if cop&&pl:isgov() then
		err("Civil Protection cannot unwarrant other Civil Protection.",cop);
		return;
	end
	if cop&&!pl:iswarranted() then
		err(pl:getname().." is not warranted.");
		return;
	end
	local fmt="";
	if cop then
		fmt=cop:getname().." unwarranted "..pl:getname()..".";
	else
		fmt=pl:getname().." is no longer warranted.";
	end
	pl:removestatus("wanted");
	pl:removestatus("warranted");
	prompt.send("hint",{"Unwarrant",fmt},nil,nil);
	hookrun("gov.unwarrant",cop,pl);
end

function gov.arrest(cop,pl)
	if !cop then return; end
	if !cop:iscop() then
		err("Only Civil Protection can arrest players.",cop);
		return;
	end
	if !pl:iswanted()&&!pl:isarrested() then
		err(pl:getname().." is not wanted.");
		return;
	end
	if pl:iswanted()&&!pl:isarrested() then
		netstart("gov.arrest");--client timer
		netsend(pl);
		wait.start("arrest"..pl:SteamID(),gov.arresttime,1,function()
			pl:unarrest();
		end);
		local fmt=pl:getname().." was arrested by "..cop:getname()..".";
		prompt.send("hint",{"Arrest",fmt},nil,nil);
	end
	pl:removestatus("wanted");
	pl:removestatus("warranted");
	pl:SetPos(gov.jails[rand(1,#gov.jails)]);
	hookrun("gov.arrest",cop,pl);
end

function gov.unarrest(cop,pl)
	if cop&&!pl:isarrested() then
		err(pl:getname().." is not arrested.",cop);
		return;
	end
	local fmt="";
	if cop then
		fmt=cop:getname().." unarrested "..pl:getname()..".";
	else
		fmt=pl:getname().." is no longer arrested.";
	end
	pl:removestatus("wanted");
	pl:removestatus("warranted");
	pl:removestatus("arrested");
	pl:SetPos(gov.unjails[rand(1,#gov.unjails)]);
	prompt.send("hint",{"Unarrest",fmt},nil,nil);
	hookrun("gov.unarrest",cop,pl);
end

function pl:want(cop,rsn)
	gov.want(cop,self,rsn);
end

function pl:unwant(cop)
	gov.unwant(cop,self);
end

function pl:warrant(cop,rsn)
	gov.warrant(cop,self,rsn);
end

function pl:unwarrant(cop)
	gov.unwarrant(cop,self);
end

function pl:arrest(cop)
	gov.arrest(cop,self);
end

function pl:unarrest(cop)
	gov.unarrest(cop,self);
end

cache.register({
	name="laws",
	set=function(varid,ent,cached,laws)	
		-- if !cached[varid] then cached[varid]=laws; end
		-- writestr(laws);
	end,
});