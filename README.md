# ProStore
## A small Roblox Data Store Library V1.2

## Changes

 -Fixed auto save
 -Added session join event

Pro Store is a small library built in roblox with the purpose of helping you setting up your game database schema.

- Simple
- Low amount of lines
- Very easy to learn and apply

## Features

- Make your own database schema
- You can change the schema at anytime without losing any data
- Auto save (Customizable time gap)


## API

### ProStore:Get(playerInstance, ParameterName)

Returns the user parameter via string.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Get user field
local newValue = ProStore:Get(player, "Coins")
```
### ProStore:Set(playerInstance, ParameterName, NewValue)
Updates the value of this field. Doesn't return anything.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Sets the coin amount to 20
ProStore:Set(player, "Coins", 20)
	
--Gets the amount of coins
local coins = ProStore:Get(player, "Coins")
print(coins) --> Prints "20"
```
### ProStore:Inc(playerInstance, ParameterName, Amount)
Increments a certain amount into the field (only works on numb type). Returns new updated value.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Increments the amount of coins by 20
local newValue = ProStore:Inc(player, "Coins", 20)
```

### ProStore:Add(playerInstance, ParameterName, Item)
Adds a new value (of any type) into the array. Returns updated array.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Adds a new item into the players inventory
local newInventory = ProStore:Inc(player, "Inventory", {id = "Excalibur", type = "Sword"})
```

### ProStore:ForceSave(playerInstance)
Forces the server to save this player data, do not use this very often as roblox has a limited amount of requests per minute. I'd personally recommend using it for robux purchases to avoid data loss.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Forces the server to save this player data
ProStore:ForceSave(player)
```

### ProStore:GetOfflineData(UserId)
Returns an offline user data via his ID. This can be used for user lookup.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Gets the user data by ID (this ID belongs to prooheckcp)
local data = ProStore:GetOfflineData(30165668)
```

### ProStore:SetOfflineData(UserId, data)
Changes the data regarding an offline user.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

--Gets the user data by ID (this ID belongs to prooheckcp)
	local data = ProStore:GetOfflineData(30165668)
	data.Points = 500
--Save the changes on the offline player
	ProStore:SetOfflineData(30165668, data)
```

### ProStore:SetOfflineData(function(playerInstance, userData)end)
The function gets played whenever a user joins the game. This funciton has access to both the player instance and the users data.

Example:
```lua
local ProStore = require(script.Parent.ProStore) --Change to script location

ProStore:AddStartEvent(function(player, userData)
	print(player.Name.." just joined the game")
	print(userData)
end)

```

## Installation

All it requires is Roblox Studio.

* Download it from here: https://www.roblox.com/library/6419050082/ProStore-DataStore-Library
* In Roblox Studio open the "Toolbox" window and open the model.
*  Now in the **Explorer** drag and drop the script from the **Workspace** into the **ServerScriptService**.
*  Open the **ProStore** Instance and open the script named "**ServiceEvents**". Inside of this script you should edit the database schema into your needs. You can also set some custom settings as explained in the scripts comments.

## Contact

Found any problem or simply wanna give some feedback regarding the library? Just hit me up!

Discord: レム デベロッパー | prooheckcp#2001

Twitter: https://twitter.com/Prooheckcp


**100% free and open source**
