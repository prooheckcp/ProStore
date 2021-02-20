# ProStore
## A small Roblox Data Store Library
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
