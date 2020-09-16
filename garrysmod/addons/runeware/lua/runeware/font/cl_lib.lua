local createfont=surface.CreateFont;
font=font||{};
font.scaled=font.scaled||{};
font.dbg=font.dbg||false;
font.enabled=font.enabled||true;
if !font.enabled then return; end
function font.add(name,font,size)
	createfont(name,{
		font = font,
		size = size,
		antialias = true
	});
end

function font.addscaledfont(name, fontname, start, count)
	font.scaled[name] = {start = start, finish = (count - 1) * 4 + start}
	for i = 1, count do
		local siz = start + (i - 1) * 4
		font.add(name..tonumber(siz), fontname, siz)
	end
end