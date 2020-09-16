if !cmd.enabled then return; end
local match       = string.match;
local tableremove = table.remove;
local tableconcat = table.concat;
local entscreate  = ents.Create;
local tonumber    = tonumber;

local CMD         = {};
CMD.name          = "spawn";
CMD.usage         = "spawn <quantity> <itemname>";
CMD.description   = "Spawn an item.";
CMD.power         = role.developer;

function CMD.run(pl,args,argstr)
	if pl:isconsole() then cmd.help(CMD,pl,"Player only."); return; end
	if #args < 2 then
		cmd.help(CMD,pl);
		return;
	end
	local quantity = tonumber(tableremove(args,1));
	if !quantity || quantity <= 0 then
		cmd.help(CMD,pl,"Quantity must be a number greater than 0.");
		return;
	end
	local itemname = tableconcat(args," ");
	local itemid   = item[itemname];
	local _item    = item[itemid];
	local stack    = _item.stack||1;
	if quantity > stack then
		cmd.help(CMD,pl,"This item has a max stack size of: "..stack);
		return;
	end
	if !itemid then
		cmd.help(CMD,pl,"Invalid Item: "..itemname);
		return;
	end
	local spawnpos = pl:EyePos()+pl:GetAimVector()*20;
	item.spawn(spawnpos,_item,quantity);
end
cmd.add(CMD);