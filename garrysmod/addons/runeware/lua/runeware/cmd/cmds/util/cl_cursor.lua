if !cmd.enabled then return; end
local enablecursor = gui.EnableScreenClicker;
local setcursorpos = input.SetCursorPos;
local getcursorpos = input.GetCursorPos;

local CMD       = {};
CMD.name        = "cursor";
CMD.usage       = "cursor";
CMD.description = "Toggle cursor";
CMD.power       = role.member;
CMD.enabled     = false;

function CMD.run(pl,args,argstr)
	CMD.enabled = !CMD.enabled;
	enablecursor(CMD.enabled);
end
cmd.add(CMD);