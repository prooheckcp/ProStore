local settings = {
	["Keycode"] = "someRandomKey",
	--If Roblox Studio is allowed to save player data
	["SaveOnStudio"] = true,
	--If the console should print all changes
	["actionsFeedback"] = true,
	--How often does the server auto save? (Default: every 3 minutes)
	["autoSave"] = 3,
	["schema"] = {

		["Points"] = 0,
		["Coins"] = 10,
		["Inventory"] = {},
		["stats"] = {
			["health"] = 0,
			["strength"] = 0,
			["power"] = 0
		}

	}
}

return settings
