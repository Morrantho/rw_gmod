if !job.enabled then return; end
local random=math.random;
local plyall=player.GetAll;
local clamp=math.Clamp;
local writeuint=net.WriteUInt;
local hookadd=hook.Add;
local assert=assert;
local findmeta=FindMetaTable;
local pl=findmeta("Player");

function job.loadplayer(data,pl)
	pl:setjob("citizen");
end
hookadd("db.loadplayer","job.loadplayer",job.loadplayer);

function job.setjob(pl,jobname,mdl)
	local jobid=job[jobname];
	assert(jobid,"Invalid Job: "..jobname);
	local _job=job[jobid];
	cache.write("job","set",pl,jobid,pl);
	print( "I kill you in job." )
	pl:KillSilent();
end

function job.loadout(pl)
	local loadout=pl:getjob().loadout;
	for i=1,#loadout do
		pl:Give(loadout[i]);
	end
end

function job.spawn(pl)
	local spawns=pl:getjob().spawns;
	local spawn=spawns[random(1,#spawns)];
	pl:SetPos(spawn);
end

function pl:setjob(jobname,mdl)
	job.setjob(self,jobname,mdl);
end

cache.register({
	name="job",
	set=function(varid,ent,cached,jobid)
		cached[varid]=jobid;
		writeuint(jobid,4); -- 0-15		
	end
});