if !cmd.enabled then return; end
local CMD       = {};
CMD.name        = "additem";
CMD.usage       = "additem <quantity> <itemname>";
CMD.description = "Add an item to your inventory.";
CMD.power       = role.developer; -- this is really just a test command

function CMD.run(pl,args,argstr)
	if #args < 2 then
		cmd.help(CMD,pl);
		return;
	end
	local quantity = tonumber(table.remove(args,1));
	if !quantity || quantity <= 0 then
		cmd.help(CMD,pl,"Quantity must be a number greater than 0.");
		return;
	end
	local itemname = table.concat(args," ");
	local itemid   = item[itemname];
	if !itemid then
		cmd.help(CMD,pl,"Invalid Item: "..itemname);
		return;
	end
	local durability = item[itemid].durability||0;
	pl:additem(itemname,quantity,durability);
end
cmd.add(CMD);