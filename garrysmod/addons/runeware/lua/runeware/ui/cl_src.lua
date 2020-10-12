if !ui.enabled then return; end
local hookadd=hook.Add;
local hookremove=hook.Remove;
local localplayer=LocalPlayer;
local scrw,scrh=ScrW,ScrH;
local drawrect=surface.DrawRect;
local setcolor=surface.SetDrawColor;
local getcolor=color.get;
local localplayer=LocalPlayer;

function ui.load()
	print("ui.load:",localplayer():getname());
end

function ui.HUDShouldDraw(elem)
	if ui.disabled && ui.disabled[elem] then return false; end
end
hookadd("HUDShouldDraw","ui.HUDShouldDraw",ui.HUDShouldDraw);

function ui.PlayerBindPress(pl,bnd,prs)
	if !ui.binds[bnd] then return false; end
	if prs then
		pl:ConCommand(ui.binds[bnd]);
		return true;
	end
end
hookadd("PlayerBindPress","ui.PlayerBindPress",ui.PlayerBindPress);

local function crosshair()
	local sw,sh = scrw(),scrh();
	local w,h = 4,4;
	local x,y = sw/2-w/2,sh/2-h/2;
	setcolor(color.get("whitest"));
	drawrect(x,y,w,h);
end

local function paint()
	crosshair();
end
hookadd("HUDPaint","paint",paint);