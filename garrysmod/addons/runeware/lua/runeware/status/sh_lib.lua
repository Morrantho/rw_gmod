local pl=FindMetaTable("Entity");
status=status||{};
status.dbg=status.dbg||false;
status.enabled=status.enabled||true;
if !status.enabled then return; end
function status.add(STATUS)
	assert(STATUS.name,"Status name required.");
	assert(STATUS.description,"Status description requried.");
	assert(type(STATUS.duration) == "number","Status duration must be a number.");
	assert(STATUS.img,"Status img required.");
	assert(STATUS.modifier,"Status modifier requried.");
	assert(STATUS.maxstacks,"Status maxstacks required.");
	assert(STATUS.on,"Status on callback required.");
	assert(STATUS.off,"Status off callback requried.");
	assert(STATUS.procs,"Proc Time required."); -- how frequently the status should proc. 0 to not proc
	if STATUS.procs > 0 then
		assert(STATUS.proc,"Proc Callback required.");
	end
	local len   = #status+1;
	status[len] = STATUS;
	status[STATUS.name] = len;
	if status.dbg then
		print("status.add: ",STATUS.name,len);
	end
	status.bits = tobits(len);
end

function status.getstatus(pl,statusname)
	local statusid = status[statusname];
	assert(statusid,"Invalid Status: "..statusname);
	local data = cache.get(pl,"status");
	if !data then return; end
	return data[statusid];
end

function status.hasstatus(pl,statusname)
	return status.getstatus(pl,statusname) ~= nil;
end

function status.timeleft(pl,statusname)
	if !status.hasstatus(pl,statusname) then return; end
	local sid = pl:SteamID();
	local statusid = status[statusname];
	return wait.timeleft(sid.."_status_"..statusid);
end

function status.addstatus(pl,statusname)
	local statusid = status[statusname];
	assert(statusid,"Invalid Status: "..statusname);
	local sid      = pl:SteamID();
	local waitid   = sid.."_status_"..statusid;
	local STATUS   = status[statusid];
	local stacks   = pl:getstatus(statusname);
	if stacks && stacks > STATUS.maxstacks then return; end
	if stacks && stacks < STATUS.maxstacks then
		stacks = stacks+1;
	elseif !stacks then
		stacks = 1;
	end
	wait.stop(waitid);
	STATUS.on(pl,stacks);
	local procs = 1;
	if STATUS.procs > 0 then procs = STATUS.procs; end	
	wait.start(waitid,STATUS.duration,procs,function(repsleft)
		if STATUS.proc then STATUS.proc(pl,stacks,repsleft); end
		if repsleft == 0 then
			status.removestatus(pl,statusname);
			STATUS.off(pl,stacks,repsleft);
		end
	end);
	if SERVER then
		cache.write("status","add",pl,{statusid,stacks});
	end
end

function status.removestatus(pl,statusname)
	local statusid = status[statusname];
	assert(statusid,"Invalid Status: "..statusname);
	local sid      = pl:SteamID();
	local waitid   = sid.."_status_"..statusid;
	local stacks   = pl:getstatus(statusname);
	if !stacks then return; end
	if SERVER then
		cache.write("status","remove",pl,{statusid});
	end
	wait.stop(waitid);
end

function pl:hasstatus(statusname)
	return status.hasstatus(self,statusname);
end

function pl:getstatus(statusname)
	return status.getstatus(self,statusname);
end

function pl:addstatus(statusname)
	return status.addstatus(self,statusname);
end

function pl:removestatus(statusname)
	return status.removestatus(self,statusname);
end

function pl:getstatustimeleft(statusname)
	return status.timeleft(self,statusname);
end