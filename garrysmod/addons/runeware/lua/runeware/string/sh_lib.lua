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

function string:totitle()
	local s="";
	local t=self:Split(" ");
	for i=1,#t do
		local word=t[i];
		s=s..word:sub(1,1):upper()..word:sub(2,#word).." ";
	end
	return s:sub(1,#s-1);
end