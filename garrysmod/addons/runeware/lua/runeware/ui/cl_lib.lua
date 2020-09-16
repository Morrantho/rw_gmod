local cmdadd=concommand.Add;
local vguireg=vgui.Register;
local vguinew=vgui.Create;
ui=ui||{};
ui.dbg=ui.dbg||false;
ui.enabled=ui.enabled||true;
if !ui.enabled then return; end

local function handleinit(cls)
	if !IsValid(_G[cls]) then
		_G[cls]=vguinew(cls);
	else
		_G[cls]:Remove();
	end
end

function ui.add(cls,pnl,base)
	vguireg(cls,pnl,base);
	cmdadd(cls,function() handleinit(cls); end);
end