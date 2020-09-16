require("chttp")

local dbg = false

gcord = {
    webhooks = {},
}
local URL = "https://discordapp.com/api/webhooks/%s/%s"

-- Locals 

local function queryWebhook( channelID, webhookKey, content )
    local query = {
        method = "POST",
        url = Format(URL, channelID, webhookKey),
        body = util.TableToJSON(content),
        type = "application/json"
    }

    if dbg then
        print("URL: "..query.url)
        PrintTable(content)
        query.success = function(code, body)
            print("Code: "..code)
            print("Body: "..body)
        end
    end

    if !CHTTP(query) then
        print("Unsuccessful discord webhook query to "..channelID.."/"..webhookKey)
    end
end

-- Library functions

function gcord.addWebhook( name, chanID, key )
    assert(isstring(name), "Name required for addWebhook name")
    assert(isstring(chanID), "String required for channel id")
    assert(isstring(key), "String required for webhook api key")
    gcord.webhooks[name] = {key = key, id = chanID}
end

function gcord.queryWebhook( webhookName, content )
    local hook = gcord.webhooks[webhookName]
    assert(hook, "Invalid webhook "..webhookName)

    queryWebhook(hook.id, hook.key, content)
end

