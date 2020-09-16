wait=wait||{};
wait.dbg=wait.dbg||false;
wait.enabled=wait.enabled||true;
if !wait.enabled then return; end
local hookadd=hook.Add;

function wait.now(delay,func)
	local len = #wait+1;
	wait[len] = {
		start = CurTime(),
		delay = delay,
		func  = func
	};
	if wait.dbg then
		print("wait.now: id: "..len.." delay: "..delay);
	end
end

function wait.exists(name)
	return wait[name]!=nil;
end

function wait.timeleft(name)
	if !wait.exists(name) then return; end
	local t = CurTime();
	return wait[name].delay-(t-wait[name].start);
end

function wait.stop(name)
	if wait.dbg then
		print("wait.stop: name: "..name);
	end
	wait[name] = nil;
end

function wait.start(name,delay,reps,func)
	if wait[name] then wait[name]=nil; end
	wait[name] =
	{
		start = CurTime(),
		delay = delay,
		reps  = reps,
		func  = func
	};
	if reps == 0 then wait[name].infinite = true; end
	if wait.dbg then
		print("wait.start: name: "..name.." delay: "..delay.." reps: "..reps);
	end
end

function wait.tick()
	for i,_ in pairs(wait) do
		local v = wait[i];
		if !v || type(v) ~= "table" then continue; end
		local diff = CurTime()-v.start;
		local isnamed = type(i) == "string";
		if diff > v.delay then
			if isnamed then
				if v.infinite then
					v.start = CurTime();
					v.func();
				else
					if v.reps > 0 then
						v.start = CurTime();
						v.reps = v.reps-1;
						v.func(v.reps);
					end
					if wait.dbg then
						print("wait.tick: name: "..i.." repsleft: "..v.reps);
					end					
					if v.reps < 1 then wait[i] = nil; end
				end
			else
				if wait.dbg then
					print("wait.tick: id: "..i);
				end
				table.remove(wait,i);
				v.func();
			end
		end
	end
end
hookadd("Tick","wait.tick",wait.tick);