# gcord
## Shared

## Server

<details>
  <summary>void gcord.addWebhook( string name, string chanID, string key )</summary>
  
  ```lua
  gcord.addWebhook( string name, string chanID, string key )
  ```
  ### Description:
  * Stores data on a webhook to be executed later via gcord.queryWebhook
  ### Args:
  * string name
    * The identifier to be given to a webhook so that it can be used later
  * string chanId
    * The discord snowflake of a channel containing your webhook
  * string key
    * The API key of a webhook in the given channel
  ### Returns:
  * void
  ### Example:
  ```lua
  gcord.addWebhook( "gmodChat", "012345678987654321",  "Secret-Webhook-APIKey")

  hook.Add("PlayerSay", "testTextChat", function( ply, txt )
    local name = ply:Name()

    gcord.queryWebhook("gmodStaffChat", {
        --Content is the content of the message
        content = txt,
        --Username is the name of the bot
        username = name
    })
  end)
  ```
  ### Output: 
  When pyg says "He peed on my rug" in chat
  
  ![outputimage](https://i.imgur.com/txbc9bR.png)
</details>

<details>
  <summary>void gcord.queryWebhook( string webhookName, table content )</summary>
  
  ```lua
  gcord.queryWebhook( string webhookName, table content )
  ```
  ### Description:
  * Executes a discord webhook added via gcord.addWebhook
  ### Args:
  * string webhookName
    * The identifier given to a webhook
  * table content
    * The json data to be sent to the webhook [see discord developer portal for executing webhooks](https://discord.com/developers/docs/resources/webhook#execute-webhook)
  ### Returns:
  * void
  ### Example:
  ```lua
  gcord.addWebhook( "gmodChat", "012345678987654321",  "Secret-Webhook-APIKey")

  hook.Add("PlayerSay", "testTextChat", function( ply, txt )
    local name = ply:Name()

    gcord.queryWebhook("gmodStaffChat", {
        content = txt,
        username = name
    })
  end)
  ```
  ### Output: 
  When pyg says "He peed on my rug" in chat
  
  ![outputimage](https://i.imgur.com/txbc9bR.png)
</details>

## Client
