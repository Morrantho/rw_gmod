string.dbg=string.dbg||false;

function string.occurrences(str,substr)
	local occurs = 0;
	for i=1,#str do
		if str:sub(i,i+#substr-1) == substr then
			occurs = occurs+1;
		end
		i=i+1;
	end
	return occurs;
end