---------------------
-- !!!IMPORTANT!!! --
---------------------
-- Discord API keys are like super duper
-- important. Don't fucking give these away
-- or i'll strangle each and every one of you
-- they literally can give full access to the
-- discord server.            ~Snivy

                    --Your name     Channel ID              Webhook API key
gcord.addWebhook( "gmodStaffChat", "750928377283870822",  "VF3cONpwFVDqMwPwZBbSx0r4NAs-B2JRTJ3rWO8CrO8lmytc2sqWH1cNZz-0RM28t1EJ")

hook.Add("PlayerSay", "testTextChat", function( ply, txt )
    local name = ply:Name()

    gcord.queryWebhook("gmodStaffChat", {
        content = txt,
        username = name
    })
end)

gcord.queryWebhook("gmodStaffChat", {
    content = "Server Start, debug print.",
    username = "Gmod-Bot"
})