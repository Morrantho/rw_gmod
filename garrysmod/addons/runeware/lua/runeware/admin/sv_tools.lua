if !admin.enabled then return; end
local clamp = math.Clamp;
toolrestraints = {};

function toolrestraints.elastic(pl,tool)
	local width=tool:GetClientNumber("width");
	if width<0||width>10 then
		err("Elastic width must be between 0-10.",pl);
		return false;
	end
	return true;
end

function toolrestraints.hydraulic(pl,tool)
	local dist=tool:GetClientNumber("addlength");
	local spd=tool:GetClientNumber("speed");
	if dist<0||dist>250 then
		err("Hydraulic distance must be between 0-250.",pl);
		return false;
	end
	if spd < 0 || spd > 250 then
		err("Hydraulic speed must be between 0-250.",pl);
		return false;
	end
	return true;
end

function toolrestraints.motor(pl,tool)
	local torque=tool:GetClientNumber("torque");
	if torque<0||torque>500 then
		err("Hydraulic speed must be between 0-500.",pl);
		return false;
	end
	return true;
end

function toolrestraints.muscle(pl,tool)
	local width=tool:GetClientNumber("width");
	local dist=tool:GetClientNumber("addlength");
	local spd=tool:GetClientNumber("period");
	if dist<0||dist>250 then
		err("Muscle distance must be between 0-250.",pl);
		return false;
	end	
	if width<0||width>10 then
		err("Muscle width must be between 0-10.",pl);
		return false;
	end
	if spd<0||spd>250 then
		err("Muscle speed must be between 0-250.",pl);
		return false;
	end
	return true;
end

function toolrestraints.pulley(pl,tool)
	local width=tool:GetClientNumber("width");
	if width<0||width>10 then
		err("Pulley width must be between 0-10.",pl);
		return false;
	end
	return true;
end

local removables =
{
	["gmod_lamp"] = true,
	["gmod_light"] = true,
	["gmod_button"] = true,
	["prop_physics"] = true,
	["keypad"] = true,
}

function toolrestraints.remover(pl,tool)
	local ent = pl:GetEyeTrace().Entity
	if !IsValid( ent ) then return false end
	if !removables[ ent:GetClass() ] then err( "You can not remove this entity." ) return false end
	return true
end

function toolrestraints.rope(pl,tool)
	local width=tool:GetClientNumber("width");
	if width<0||width>10 then
		err("Rope width must be between 0-10.",pl);
		return false;
	end
	return true;
end

function toolrestraints.slider(pl,tool)
	local width=tool:GetClientNumber("width");
	if width<0||width>10 then
		err("Slider width must be between 0-10.",pl);
		return false;
	end
	return true;
end

function toolrestraints.winch(pl,tool)
	local width=tool:GetClientNumber("rope_width");
	local fwd=tool:GetClientNumber("fwd_speed");
	local bwd=tool:GetClientNumber("bwd_speed");
	if width<0||width>10 then
		err("Winch width must be between 0-10.",pl);
		return false;
	end
	if fwd<0||fwd>250 then
		err("Winch forward speed must be between 0-250.");
		return false;
	end
	if bwd<0||bwd>250 then
		err("Winch backward speed must be between 0-250.");
		return false;
	end	
	return true;
end

function toolrestraints.material(pl,tool,tr)
	if IsValid(tr.Entity)&&tr.Entity:IsPlayer() then
		err("You cannot set another player's material.",pl);
		return false;
	end
	return true;
end

function toolrestraints.colour(pl,tool,tr)--fucking brits
	if IsValid(tr.Entity) && tr.Entity:IsPlayer() then
		err("You cannot set another player's color.",pl);
		return false;
	end
	return true;
end

function toolrestraints.light(pl,tool,tr)
	local length = tool:GetClientNumber("ropelength");
	if length<0||length>10 then
		err("Light rope length must be between 0-10.",pl);
		return false;
	end
	return true;
end

function admin.CanTool(pl,tr,tool)
	if admin.bannedtools[tool] then return false; end
	if toolrestraints[tool] then
		return toolrestraints[tool](pl,pl:GetTool(tool),tr);
	end
	return true;
end
hook.Add("CanTool","admin.CanTool",admin.CanTool);