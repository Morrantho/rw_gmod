<!---------------------------------------------------------------------------->
<!--_global-->
<!---------------------------------------------------------------------------->
# _global
<!------------------------------------------------------------------>
<!--Shared-->
<!------------------------------------------------------------------>
<details>
<summary>Shared</summary>
<!-------------------------------------------------------->
<!--Shared Lib-->
<!-------------------------------------------------------->
<details>
<summary>Lib</summary>
<!---------------------------------------------->
<!--choose-->
<!---------------------------------------------->
<details>
<summary>

```lua
any choose(bool cond,any a,any b);
```
</summary>
Description:

+ Returns a if cond is true, else returns b.

Args:
+ bool cond
	+ The conditional you wish to evaluate.
+ any a
	+ The value returned if cond is true.
+ any b
	+ The value returned if cond is false.

Example:
```lua
print(choose(5>10,"Yes","No"));
```
Output:
```lua
No
```
</details><!--end choose()-->
<!---------------------------------------------->
<!--findplayer-->
<!---------------------------------------------->
<details>
<summary>

```lua
Player findplayer(string arg);
```
</summary>
Description:

+ Accepts a SteamID or player name and returns a Player or nil if not found.

Args:
+ string arg
	+ A player name or SteamID.

Example:
```lua
print(findplayer("STEAM_0:0:18578874"));
print(findplayer("Legacy The Duck"));
```
Output:
```lua
Player[1] pyg
Player[2] legacy the duck
```
</details><!--end findplayer()-->
<!---------------------------------------------->
<!--tobits-->
<!---------------------------------------------->
<details>
<summary>

```lua
number tobits(number n)
```
</summary>
Description:

+ Accepts an unsigned integer and returns the number of bits it contains.

Args:
+ number n
	+ The unsigned integer whose bits you wish to count.

Example:
```lua
print(tobits(1234));
```
Output:
```lua
11
```
</details><!--end tobits()-->
<!---------------------------------------------->
<!--logtable-->
<!---------------------------------------------->
<details>
<summary>

```lua
void logtable(table t)
```
</summary>
Description:

+ Accepts a table and prints all of its indices, keys, and values recursively.

Args:
+ table t
	+ The table you wish to display.

Example:
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
Output:
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
</details><!--end logtable()-->
<!---------------------------------------------->
<!--bop-->
<!---------------------------------------------->
<details>
<summary>

```lua
number bop(string str)
```
</summary>
Description:

+ Performs C style bit operations on the input string.

Args:
+ string str
	+ The input string containing bit operations you wish to perform.

Example:
```lua
print(bop("1 << 2"));
print(bop("10 >> 1"));
print(bop("10&8"));
```
Output:
```lua
4
5
8
```
</details><!--end bop()-->
</details><!--end shared lib-->
</details><!--end shared-->
<!------------------------------------------------------------------>
<!--Server-->
<!------------------------------------------------------------------>
<details>
<summary>Server</summary>
<!-------------------------------------------------------->
<!--Server Lib-->
<!-------------------------------------------------------->
<details>
<summary>Lib</summary>
<!---------------------------------------------->
<!--success-->
<!---------------------------------------------->
<details>
<summary>

```lua
void success(string txt,table/Player to)
```
</summary>
Description:

+ Sends a net message (txt) to a table of players or a single player (to), displaying it as a success via notification.addlegacy() once received.

Args:
+ string txt
	+ The message to send.
+ table/Player to
	+ Who we're sending it to.

Example:
```lua
success("Something good happened!",findplayer("pyg"));
```
</details><!--end success()-->
<!---------------------------------------------->
<!--err-->
<!---------------------------------------------->
<details>
<summary>

```lua
void err(string txt,table/Player to);
```
</summary>
Description:

+ Sends a net message (txt) to a table of players or a single player (to), displaying it as an error via notification.addlegacy() once received.

Args:
+ string txt
	+ The message to send.
+ table/Player to
	+ Who we're sending it to.

Example:
```lua
err("Something bad happened!",findplayer("pyg"));
```
</details><!--end err()-->
</details><!--end server lib-->
</details><!--end server-->
<!------------------------------------------------------------------>
<!--Client-->
<!------------------------------------------------------------------>
<details>
<summary>Client</summary>
<!-------------------------------------------------------->
<!--Client Lib-->
<!-------------------------------------------------------->
<details>
<summary>Lib</summary>
<!---------------------------------------------->
<!--success-->
<!---------------------------------------------->
<details>
<summary>

```lua
void success(string txt)
```
</summary>
Description:

+ Displays the string (txt) as a success message via notification.addlegacy() to the local player.

Args:
+ string txt
	+ The success message to display.

Example:
```lua
success("Something good happened!");
```
</details><!--End success-->
<!---------------------------------------------->
<!--err-->
<!---------------------------------------------->
<details>
<summary>

```lua
void err(string txt);
```
</summary>
Description:

+ Displays the string (txt) as an error message via notification.addlegacy() to the local player.

Args:
+ string txt
	+ The error message to display.

Example:
```lua
err("Something bad happened!");
```
</details><!--end err-->
</details><!--end client lib-->
<details>
<summary>Callbacks</summary>
<!-------------------------------------------------------->
<!--Client Callbacks-->
<!-------------------------------------------------------->
<!---------------------------------------------->
<!--onsuccess-->
<!---------------------------------------------->
<details>
<summary>

```lua
void onsuccess();
```
</summary>
Description:

+ Reads the string sent from the server via server success(), then calls client success().
</details><!--end onsuccess-->
<!---------------------------------------------->
<!--onerr-->
<!---------------------------------------------->
<details>
<summary>

```lua
void onerr();
```
</summary>
Description:

+ Reads the string sent from the server via server err(), then calls client err().
</details><!--end onerr-->
</details><!--end client callback-->
</details><!--end client-->