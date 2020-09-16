local hookadd=hook.Add;
local getbyidx=ents.GetByIndex;
local findmeta=FindMetaTable;
local entity=findmeta("Entity");

fx=fx||{};
fx.emitters=fx.emitters||{};
fx.dbg=false;
fx.enabled=true;
if !fx.enabled then return; end

function fx.register(data)
	assert(data.name,"Missing fx name.");
	assert(data.draw,"Missing fx.draw() callback");
	local fxid=fx[data.name]||#fx+1;
	fx[data.name]=fxid;
	fx[fxid]=data;
end

function fx.add(ent,name)
	local fxid=fx[name];
	assert(fxid,"Invalid FX: "..name);
	if !IsValid(ent) then return; end
	local entidx=ent:EntIndex();
	if !fx.emitters[entidx] then
		fx.emitters[entidx]={};
	end
	if fx.emitters[entidx][fxid] then return; end
	fx.emitters[entidx][fxid]=ParticleEmitter(ent:GetPos());
end

function fx.remove(ent,name)
	local fxid=fx[name];
	assert(fxid,"Invalid FX: "..name);
	if !IsValid(ent) then return; end
	local entidx=ent:EntIndex();
	if !fx.emitters[entidx] then return; end
	if !fx.emitters[entidx][fxid] then return; end
	fx.emitters[entidx][fxid]:Finish();
	fx.emitters[entidx][fxid]=nil;
end

function fx.draw()
	for entidx,emitters in pairs(fx.emitters) do
		for fxid,emitter in pairs(emitters) do
			local ent=getbyidx(entidx);
			if !IsValid(ent) then
				if IsValid(emitter) then emitter:Finish(); end
				fx.emitters[entidx][fxid]=nil;
				continue;
			end
			fx[fxid].draw(emitter,getbyidx(entidx));
		end
	end
end
hookadd("HUDPaint","fx.draw",fx.draw);

function entity:addfx(name)
	fx.add(self,name);
end

function entity:removefx(name)
	fx.remove(self,name);
end