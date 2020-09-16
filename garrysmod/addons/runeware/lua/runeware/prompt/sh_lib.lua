prompt=prompt||{};
prompt.dbg=prompt.dbg||false;
prompt.enabled=prompt.enabled||true;
if !prompt.enabled then return; end
function prompt.register(data)
	if prompt[data.name] then
		prompt[prompt[data.name]] = data;
		return;
	end
	local len = #prompt+1;
	prompt[len] = data;
	prompt[data.name] = len;
	prompt.bits = tobits(len);
end