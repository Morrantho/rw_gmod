local WHITE_THRESH = math.pow(75, 2)

util.AddNetworkString("ui.warningIndicator")

local function tracemiss(ent, bullet)
    if !bullet.Attacker:IsPlayer() then return end
    for k, ply in pairs(player.GetAll()) do
        if bullet.Attacker == ply then continue end

        local point = ply:GetPos() + ply:OBBCenter()
        local linePoint = bullet.Src 
        local v = (point - linePoint):Dot(bullet.Dir)
        if v < 0 then continue end
        local meetPoint = linePoint + bullet.Dir * v

        if meetPoint:DistToSqr(point) <= WHITE_THRESH then
            net.Start("ui.warningIndicator")
            net.WriteUInt(bullet.Attacker:UserID(), 7)
            net.Send(ply)
        end

    end
end

--hook.Add("EntityFireBullets", "ui.tracemiss", tracemiss)