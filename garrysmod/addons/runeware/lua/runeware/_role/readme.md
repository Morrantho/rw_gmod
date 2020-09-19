# _role
## Shared

<details>
<summary>Methods</summary>

<details>
<summary>Void role.add(String name)</summary>

### Description:
* Registers a role by name, creating a unique index for future networking.
### Args:
* name
* The display name of the role you are creating.
### Example:
```lua
role.add("SuperAdmin");
```
</details>

<details>
<summary>Number role.get(String name)</summary>

### Description:
* Returns a role's unique index by its role name. The same one that was created using role.add().
### Args:
* name
* The name of the role who's index you wish to be returned.
### Example:
```lua
local id=role.get("SuperAdmin");
print(id);
```
### Output:
```lua
6
```
</details>

<details>
<summary>Number Player:getrole()</summary>

### Description:
* Returns the player's role / power as an Integer. Role powers are simply array indices.
### Args:
* none
### Example:
```lua
local pyg=findplayer("pyg");
print(pyg:getrole()); -- root
```
### Output:
```lua
8
```
</details>

<details>
<summary>Number Player:getpower()</summary>

### Description:
* Returns the player's role / power as an Integer. Role powers are simply array indices.
* Alias of Player:getpower().
### Args:
* none
### Example:
```lua
local pyg=findplayer("pyg");
print(pyg:getpower()); -- root
```
### Output:
```lua
8
```
</details>
</details>


## Server
<details>
<summary>Void role.set(Player pl,Player admin,String rolename)</summary>

### Description:
* Sets the player "pl"'s role to "rolename" by the admin "admin".
### Args:
* Player pl
* The player whose role should be changed.
* Player admin
* The admin who is changing "pl"'s role
* String rolename
* The name of the role that "pl" should be set to.
### Example:
```lua
local pyg=findplayer("pyg");
local leg=findplayer("legacy");
role.set(leg,pyg,"developer");
```
</details>

<details>
<summary>Void Player:setrole(Player admin,String rolename)</summary>

### Description:
* Sets the player "pl"'s role to "rolename" by the admin "admin".
* Alias of role.set()
### Args:
* Player admin
* The admin who is changing "pl"'s role
* String rolename
* The name of the role that "pl" should be set to.
### Example:
```lua
local pyg=findplayer("pyg");
local leg=findplayer("legacy");
leg:setrole(pyg,"developer");
```
</details>

<details>
<summary>Void role.loadplayer(Table data,Player pl)</summary>

### Description:
* Called internally by the role module once the player's data has been loaded from MySQL.
### Args:
* The player's MySQL data from the "player" MySQL table.
* The player object themselves whose role information is to be loaded.
</details>

<details>
<summary>Void role.onset(Table data,Table args)</summary>

### Description:
* Called by the cache to set a player's role.
* Can be called by: admin.setrole(), pl:setrole(), /setrole command.
### Args:
* The player's MySQL data from the "player" MySQL table.
* A table consisting of the player whose role should be set, the admin who set it or nil, and the name of the role they are being set to.
</details>

<details>
<summary>role.ongetplayer(String steamid,Player admin,String rolename,Bool exists)</summary>

### Description:
* Called when attemping to set a player's role whom is not currently online, thus a MySQL query is made in attempts to find them.
### Args:
* String steamid
* SteamID of the player who should be looked up.
* Player admin
* The admin who is attempting to set this player's role.
* String rolename
* The name of the role that "pl" should be set to.
* Bool exists
* Whether the player being looked up in MySQL actually exists.
</details>

<details>
<summary>role.onset(String steamid,Player admin,String rolename)</summary>

### Description:
* Called after MySQL saves the user's new role.
* Writes the new role to the cache.
### Args:
* String steamid
* SteamID of the player whose role was just set.
* Player admin
* The admin who set the player's role.
* String rolename
* The name of the role the user was set to.
</details>

<details>
<summary>role</summary>
</details>

## Client
