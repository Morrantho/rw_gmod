local bops  =
{
	["|"]  = bit.bor,
	["&"]  = bit.band,
	["!"]  = bit.bnot,
	["^"]  = bit.bxor,
	["<<"] = bit.lshift,
	[">>"] = bit.rshift,
};
local ws = 
{
	[" "]  = true,
	["\t"] = true,
	["\n"] = true,
	["\r"] = true,
};

function choose(cond,a,b)
	if cond then return a; else return b; end
end

function findplayer(arg)
	if type(arg) ~= "string" then return; end
	if #arg < 1 || arg[1] == "" then return; end
	arg = arg:lower();
	local plys = player.GetAll();
	for i=1,#plys do
		if !IsValid(plys[i]) then continue; end
		local name = plys[i]:getname()||"";
		name = name:lower();
		local sid  = plys[i]:SteamID();
		if !name || !sid then continue; end
		sid = sid:lower();
		if name:find(arg,1,true) || sid:find(arg,1,true) then
			return plys[i];
		end
	end
end

function tobits(n)
	local bits = 0;
	while n > 0 do
		n = bit.rshift(n,1);
		bits = bits+1;
	end
	return bits;
end

function logtable(v,indent,key)
	if not indent then indent = ""; end
	if type(v) == "table" then
		for a,b in pairs(v) do
			if type(b) == "table" then
				print(indent..a.." =");
				print(indent.."{");
			end
			logtable(b,"\t"..indent,a);
		end
		if indent == "" then return; end
		print(indent:sub(1,#indent-1).."}");
	else
		if key then
			print(indent:sub(1,#indent-1)..key.." = ",v);
		end
	end
end

function bop(str)
	local operands = {};
	local n        = "";
	local res      = 0;
	for i=1,#str+1 do
		local c = str:sub(i,i);
		if ws[c] then continue; end
		if tonumber(c) then
			n = n..c;
		else
			operands[#operands+1] = tonumber(n);
			n = "";
			local cc = str:sub(i+1,i+1);
			if cc == c then c = c..cc; i = i+1; end -- its << or >>.
			if c and bops[c] then operands[#operands+1] = bops[c]; end
		end
	end
	for i=1,#operands,3 do
		local opa = operands[i];
		local op  = operands[i+1];
		local opb = operands[i+2];
		if i % 2 ~= 0 then
			res = op(opa,opb);
		else
			local t = opa;
			opa = operands[i-1];
			opb = op;
			op  = t;
			res = op(res,opa,opb);
		end
	end
	return res;
end