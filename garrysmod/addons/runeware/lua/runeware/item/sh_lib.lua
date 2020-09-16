item=item||{};
item.dbg=item.dbg||false;
item.enabled=item.enabled||true;
if !item.enabled then return; end

function item.add(data)
	local id=item[data.name];
	if !id then id=#item+1; end
	item[id]=data;
	item[data.name]=id;
	if item.dbg then
		print("item.add: "..data.name.." "..data.category);
	end
end

function item.get(name)
	local id=item[name];
	if !id then return; end
	return item[id];
end