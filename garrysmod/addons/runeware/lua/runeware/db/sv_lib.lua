if !db.enabled then return; end
require("mysqloo");
local hookadd=hook.Add;
local hookrun=hook.Run;
local netreceive=net.Receive;
local entbyidx=ents.GetByIndex;
local readuint=net.ReadUInt;
local netstr=util.AddNetworkString;
local runcmd=RunConsoleCommand;
netstr("db.await");
db.instance=nil;

function db.connect()
	db.instance=mysqloo.connect( 
		db.host,
		db.user,
		db.pass,
		db.schema,
		db.port
	);
	function db.instance:onConnected()
		if db.dbg then print("db: connected"); end
		hookrun("db.connect");
	end
	function db.instance:onConnectionFailed(err)
		if db.dbg then print("db: connection failed"); end
	end
	db.instance:connect();
end

function db.query(query,params,extra,func)
	local ps=db.instance:prepare(query);
	for i=1,#params do
		local param = params[i];
		local t = type(param);
		if t == "string" then
			ps:setString(i,param);
		elseif t == "number" then
			ps:setNumber(i,param);
		elseif t == "bool" then
			ps:setBoolean(i,param);
		elseif !t || t == "nil" then
			ps:setNull(i);
		end
	end
	function ps:onSuccess(data)
		func(data,extra);
	end
	function ps:onError(e,_sql)
		print("-----------------------------------SQL Error----------------------------------");
		print("Error:",e);
		print("SQL:",_sql);
		print("-----------------------------------SQL Error----------------------------------");			
	end
	ps:start();
end

function db.register(name,proc) -- only saves you from having to specify the query each time
	db[name]=function(params,extra,func)
		db.query(proc,params,extra,func);
	end
end

function db.Initialize()
	db.connect();
	db.getplayer({"CONSOLE"},{entbyidx(0)},db.ongetconsole);
end
hookadd("Initialize","db.Initialize",db.Initialize);

-- wait for the player to exist on their own client before doing anything
function db.await()
	local pl=Player(readuint(7));
	db.getplayer({pl:SteamID()},{pl},db.ongetplayer);
end
netreceive("db.await",db.await);

function db.ongetconsole(data,args) -- this just fixes console support for 90% of commands
	cache.put(args[1],"name",data[1].name);
	cache.put(args[1],"role",role[data[1].role]);
end

function db.ongetplayer(data,args)
	local pl     = args[1];
	local exists = #data > 0;
	if db.dbg then
		print("db.ongetplayer: ",data,pl,exists);
	end
	if !exists then -- First Join
		local sid   = pl:SteamID();
		local name  = rwplayer.getrandomname() || pl:Name();
		local ROLE  = role[admin.defaults[sid]] || role[admin.defaultrole];
		local money = admin.defaultmoney;
		db.addplayer({sid,name,ROLE,money},args,db.onaddplayer);
	else
		db.loadplayer(data,pl);
	end
end

function db.onaddplayer(data,args)
	local pl = args[1];
	hookrun("db.onaddplayer",data,pl); -- first join
	db.loadplayer(data,pl);
end

function db.loadplayer(data,pl)
	if db.dbg then print("db.loadplayer: ",pl); end
	hookrun("db.loadplayer",data[1],pl); -- post query
end