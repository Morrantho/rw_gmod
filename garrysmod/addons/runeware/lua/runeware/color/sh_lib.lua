color=color||{};
color.dbg=color.dbg||false;
color.enabled=color.enabled||true;
color.bits=1;
if !color.enabled then return; end
function color.add(name,col)
	local id=color[name];
	if !id then id=#color+1; end
	color[name]=id;
	color[id]=col;
	if color.dbg then
		print("color:add - "..name..", "..id);
	end
	color.bits=tobits(id);
end

function color.get(name)
	local id=color[name];
	assert(id,"Attempt to access non-existant color: "..name);
	return color[id];
end