cache.register({
    name="waypoints",
    
    add=function(varid,ent,cached,netdata)
        if !cached[varid] then cached[varid]={}; end
        cached[varid][netdata.title]=netdata.pos;
        net.WriteString(netdata.title);
        net.WriteVector(netdata.pos);
        --net.WriteColor(netdata.col);
        print("WAYPOINT ADD",ent);
    end,

    remove=function(varid,ent,cached,netdata)
        cached[varid][netdata.title]=nil
        net.WriteString(netdata.title)
        print("WAYPOINT REMOVE",ent);
    end
});