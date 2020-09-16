require("chttp");
http.dbg=http.dbg||false;
http.enabled=http.enabled||true;
local tojson=util.TableToJSON;
if !http.enabled then return; end
function http.get(url,func)
	return CHTTP({
		method="GET",
		url=url,
		success=function(code,res,headers)
			func(nil,res);
		end,
		failed=function(err)
			func(err,nil);
		end
	});
end

function http.post(url,data,func,isjson)
	if isjson then data=tojson(data); end
	return CHTTP({
		method="POST",
		url=url,
		body=data,
		success=function(code,res,headers)
			func(nil,res);
		end,
		failed=function(err)
			func(err,nil);
		end
	});
end

function http.put(url,data,func,isjson)
	if isjson then data=tojson(data); end	
	return CHTTP({
		method="PUT",
		url=url,
		body=data,
		success=function(code,res,headers)
			func(nil,res);
		end,
		failed=function(err)
			func(err,nil);
		end
	});
end

function http.patch(url,data,func,isjson)
	if isjson then data=tojson(data); end	
	return CHTTP({
		method="PATCH",
		url=url,
		body=data,
		success=function(code,res,headers)
			func(nil,res);
		end,
		failed=function(err)
			func(err,nil);
		end
	});
end

function http.delete(url,data,func,isjson)
	if isjson then data=tojson(data); end	
	return CHTTP({
		method="DELETE",
		url=url,
		body=data,
		success=function(code,res,headers)
			func(nil,res);
		end,
		failed=function(err)
			func(err,nil);
		end
	});	
end