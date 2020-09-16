local addlegacy=notification.AddLegacy;
local playsnd=surface.PlaySound;
local readstr=net.ReadString;
local netrcv=net.Receive;
local print=print;

function success(txt)
	addlegacy(txt,0,3);
	playsnd("buttons/button15.wav");
end

function err(txt)
	addlegacy(txt,1,3);
	playsnd("buttons/button10.wav");
end

function onsuccess()
	success(readstr());
end
netrcv("success",onsuccess);

function onerr()
	err(readstr());
end
netrcv("err",onerr);