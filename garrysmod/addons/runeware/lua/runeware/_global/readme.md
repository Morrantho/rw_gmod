# _global
## Shared
<details>
  <summary>Any choose(cond,a,b)</summary>
  
  ```lua
  Any choose(cond,a,b)
  ```
  ### Description:
  * Returns a if cond is true, else returns b.
  ### Args:
  * cond
    * The conditional you wish to evaluate.
  * a
    * The value returned if cond is true.
  * b
    * The value returned if cond is false.
  ### Example:
  ```lua
  local str=choose(5>10,"Yes","No");
  ```
  ### Output:

  ```lua
  str="No"
  ```
</details>

<details>
  <summary>Player findplayer(arg)</summary>
  
  ```lua
  Player findplayer(arg)
  ```
  ### Description:
  * Accepts a steamid or player name and returns a Player.
  ### Args:
  * arg
    * A player name or steamid.
  ### Example:
  ```lua
  local pyg=findplayer("STEAM_0:0:18578874");
  local legacy=findplayer("Legacy The Duck");
  print(pyg);
  print(legacy);
  ```
  ### Output:
  ```lua
  Player[1] pyg
  Player[2] legacy
  ```
</details>

<details>
  <summary>Number tobits(n)</summary>
  
  ```lua
  Number tobits(n)
  ```
  ### Description:
  * Accepts an Integer and returns the number of bits it contains.
  ### Args:
  * n
    * The number whose bits you wish to count.
  ### Example:
  ```lua
  local some_num=tobits(1234);
  print(some_num);
  ```
  ### Output:
  ```lua
  11
  ```
</details>


<details>
  <summary>Void logtable(Table t)</summary>
  
  ```lua
  Void logtable(Table t)
  ```
  ### Description:
  * Accepts a table and prints all of its indices, keys, and values recursively.
  ### Args:
  * Table t
    * The table you wish to display.
  ### Example:
  ```lua
  local my_table=
  {
    name="hello",
    1234,
    {
      x=123,
      y=234
    }
  };
  
  logtable(my_table);
  ```
  ### Output:
  ```lua
  {
    name = "hello",
    1 = 1234,
    2 =
    {
      x = 123,
      y = 234
    }
  }
  ```
</details>

<details>
  <summary>Number bop(String str)</summary>
  
  ```lua
  Number bop(String str)
  ```
  ### Description:
  * Performs C style bit operations on the input string.
  ### Args:
  * String s
    * The input string containing bit operations you wish to perform.
  ### Example:
  ```lua
  print(bop("1 << 2"));
  print(bop("10 >> 1"));
  print(bop("10&8"));
  ```
  ### Output:
  ```lua
  4
  5
  8
  ```
</details>

## Server

<details>
  <summary>Void success(String msg,Table/Player to)</summary>
  
  ```lua
  Void success(String msg,Table/Player to)
  ```
  ### Description:
  * Sends the message "msg" as a notification.addlegacy to "to".
  ### Args:
  * msg
    * The message you wish "to" to receive.
  * to
    * One player or a table of players that will receive your message.
  ### Example:
  ```lua
  success("Hello");
  ```
  ### Output:
  ![output](https://media.discordapp.net/attachments/638535791676620810/755939698211291136/unknown.png)
</details>


<details>
  <summary>Void err(String msg,Table/Player to)</summary>
  
  ```lua
  Void err(String msg,Table/Player to)
  ```
  ### Description:
  * Sends the error message "msg" as a notification.addlegacy to "to".
  ### Args:
  * msg
    * The message you wish "to" to receive.  
  * to
    * One player or a table of players that will receive your message.
  ### Example:
  ```lua
  err("I'm an error.");
  ```
  ### Output:
  ![output](https://media.discordapp.net/attachments/638535791676620810/755940456826798120/unknown.png)
</details>

## Client

<details>
  <summary>Void success(String msg)</summary>
  
  ```lua
  Void success(String msg)
  ```
  ### Description:
  * Sends the message "msg" as a notification.addlegacy to the localplayer.
  ### Args:
  * msg
    * The message the localplayer will receive.
  ### Example:
  ```lua
  success("Hello");
  ```
  ### Output:
  ![output](https://media.discordapp.net/attachments/638535791676620810/755939698211291136/unknown.png)
</details>


<details>
  <summary>Void err(String msg)</summary>
  
  ```lua
  Void err(String msg)
  ```
  ### Description:
  * Sends the error message "msg" as a notification.addlegacy to the localplayer.
  ### Args:
  * msg
    * The error message the localplayer will receive.
  ### Example:
  ```lua
  err("I'm an error.");
  ```
  ### Output:
  ![output](https://media.discordapp.net/attachments/638535791676620810/755940456826798120/unknown.png)
</details>
