<!--only place hr's to signify bottoms for readability-->
# _role
<details><!--start shared-->
<summary>Shared</summary>
<details><!--start shared lib-->
<summary>Lib</summary>
<details><!--start role.add-->
<summary>

```lua
void role.add(string name);
```
</summary>
Description:

+ Registers a role (name) as a key and unique index for networking.

Args:
+ string name
	+ The name of the role you're creating.

Example:
```lua
role.add("SuperDuperAdman");
```
<hr>
</details><!--end role.add()-->

<details><!--start role.get-->
<summary>

```lua
number role.get(string name);
```
</summary>
Description:

+ Returns the role's unique index by key (name).

Args:
+ string name
	+ The role name whose index you want.

Example:
```lua
print(role.get("admin"));
```
Output:
```lua
4
```
<hr>
</details><!--end role.get()-->
</details><!--end shared lib-->
<details><!--start player-->
<summary>Player</summary>
<details><!--start Player:getrole-->
<summary>

```lua
number Player:getrole();
```
</summary>
Description:

+ Returns the player's role index / power by key.

Example:
```lua
print(findplayer("pyg"):getrole());
```
Output:
```lua
8
```
<hr>
</details><!--end Player:getrole()-->
<details><!--start Player:getpower-->
<summary>

```lua
number Player:getpower();
```
</summary>
Description:

+ Returns the player's role index / power by key.
+ Alias of Player:getrole().

Example:
```lua
print(findplayer("pyg"):getpower());
```
Output:
```lua
8
```
<hr>
</details><!--end Player:getpower()-->
</details><!--end player-->
<hr>
</details><!--end shared-->
<details><!--start server-->
<summary>Server</summary>
</details><!--end server-->
<details><!--start client-->
<summary>Client</summary>
</details><!--end client-->