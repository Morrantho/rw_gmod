local CMD = {}

CMD.name        = "entinfo";
CMD.usage       = "entinfo";
CMD.description = "Displays entity info of what you're looking at.";
CMD.power       = role.developer;

function CMD.run(pl,args,argstr)

    if !pl:Alive() then err( "You can not run this command while dead.", pl ) return end
    local ent = pl:GetEyeTrace().Entity
    local tbl =
    {
        "green", "Ent Class: ",
        "yellow", ( ent:GetClass() || "NO CLASS" ) .. "\n",
        "green", "Ent Index: ",
        "yellow", ( ent:EntIndex() || "NO INDEX( HOW? )" ) .. "\n",
        "green", "Ent Model: ",
        "yellow", ent:GetModel() || "NONE"
    }
    pmsg( pl, tbl )
end

cmd.add(CMD);