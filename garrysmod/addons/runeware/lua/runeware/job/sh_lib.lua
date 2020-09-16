local plyall=player.GetAll;
local findmeta=FindMetaTable;
local pl=findmeta("Player");
job=job||{};
job.dbg=job.dbg||false;
job.enabled=job.enabled||true;
if !job.enabled then return; end
function job.add(data)
	local id=job[data.name];
	if !id then id=#job+1; end
	job[id]=data;
	job[data.name]=id;
	job.bits=tobits(id);
end

function job.getplayers(jobname)
	assert(job[jobname],"Invalid Job: "..jobname);
	local plys=plyall();
	local jobplys={};
	for i=1,#plys do
		local _job=plys[i]:getjob();
		if _job.name==jobname then
			jobplys[#jobplys+1]=plys[i];
		end
	end
	return jobplys;
end

function job.getteamplayers(tm)
	local plys=plyall();
	local teamplys={};
	for i=1,#plys do
		local _job=plys[i]:getjob();
		if _job.team==tm then
			teamplys[#teamplys+1]=plys[i];
		end
	end
	return teamplys;
end
function job.getid(pl) return cache.get(pl,"job")||job.citizen; end
function job.getjob(pl) return job[job.getid(pl)]; end
function job.getname(pl) return job.getjob(pl).name; end
function job.getteam(pl) return job.getjob(pl).team; end
function job.iscop(pl)
	local cops=job.getplayers("cop");
	for i=1,#cops do if cops[i]==pl then return true; end end
	return false;
end
function job.ismayor(pl) return job.getname(pl)=="mayor"; end
function job.ischief(pl) return job.getname(pl)=="chief"; end
function job.isgov(pl) return job.getteam(pl)=="civil protection"; end
function job.iscitizen(pl) return job.getteam(pl)=="citizen"; end

function pl:getjobid() return job.getid(self); end
function pl:getjob() return job.getjob(self); end
function pl:getjobname() return job.getname(self); end
function pl:getjobteam() return job.getteam(self); end
function pl:iscop() return job.iscop(self); end
function pl:ismayor() return job.ismayor(self); end
function pl:ischief() return job.ischief(self); end
function pl:isgov() return job.isgov(self); end
function pl:iscitizen() return job.iscitizen(self); end