local addres=resource.AddSingleFile;
local filefind=file.Find;
local addcs=AddCSLuaFile;
local inc=include;
local print=print;
dbg=true;

function loaddir(dir,rel,func,fil,fol)
	fil,fol=filefind(dir,rel,"nameasc");
	for a,b in pairs(fil) do 
		func(dir:sub(1,#dir-1),b);
	end
	for a,b in pairs(fol) do
		loaddir(dir:sub(1,#dir-1)..b.."/*",rel,func,fil,fol);
	end
end

function sendres()
	if !SERVER then return; end
	loaddir("addons/runeware/*","MOD",function(dir,fil)
		if dir:find("lua")||fil:find(".lua") then return; end
		addres(dir..fil);
		if dbg then
			print("sendres: "..dir..fil);
		end
	end);
end

function sendlua(basedir)
	if !SERVER then return; end
	if !basedir then basedir="runeware/*"; end
	loaddir(basedir,"LUA",function(dir,fil)
		if !fil:find(".lua") then return; end
		if fil:find("sv_") then return; end
		if dbg then print("sendlua: "..dir..fil); end
		addcs(dir..fil);
	end);
end

function loadshlib(basedir)
	if !basedir then basedir="runeware/*"; end	
	loaddir(basedir,"LUA",function(dir,fil)
		if !fil:find(".lua") then return; end		
		if !fil:find("sh_lib") then return; end
		inc(dir..fil);
		if dbg then print("loadshlib: "..dir..fil); end
	end);
end

function loadlib(basedir)
	if !basedir then basedir="runeware/*"; end
	loaddir(basedir,"LUA",function(dir,fil)
		if !fil:find(".lua") then return; end		
		if fil:find("sh_lib") then return; end
		if !fil:find("lib") then return; end
		if SERVER && fil:find("cl_") then return; end
		inc(dir..fil);
		if dbg then print("loadlib: "..dir..fil); end
	end);
end

function loadsrc(basedir)
	if !basedir then basedir="runeware/*"; end	
	loaddir(basedir,"LUA",function(dir,fil)
		if !fil:find(".lua") then return; end		
		if fil:find("lib") then return; end
		if SERVER && fil:find("cl_") then return; end
		if dbg then print("loadsrc: "..dir..fil); end
		inc(dir..fil);
	end);
end

sendres();
sendlua();
loadshlib();
loadlib();
loadsrc();