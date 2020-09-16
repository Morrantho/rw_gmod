local vecrand=VectorRand;

fx.register({
	name="graced",
	draw=function(emitter,ent)
		local pos,ang=ent:GetPos(),ent:GetAngles();
		pos.z=pos.z+48;
		local p=emitter:Add("particle/fire",pos);
		local col=color.get("orange");
		p:SetDieTime(1);
		p:SetStartSize(5);
		p:SetEndSize(0);
		p:SetColor(col.r,col.g,col.b);
		p:SetVelocity(vecrand(-8,8));
	end
});