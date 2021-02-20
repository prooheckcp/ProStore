-- Datastore library developed by Prooheckcp at
-- 02/19/2021
-- 

--Settings--

local keyCode = "keyuwuOwO"
local actionsFeedback = true
local autoSave = 3 --How many times per minute does it save the user data
------------

-- This is an example of a schema
-- Change it to your needs

local your_schema = {

	["Points"] = 0,
	["Inventory"] = {},
	["stats"] = {
		["health"] = 0,
		["strength"] = 0,
		["power"] = 0
	}

}

--------------------------------
-- Do not touch               --
-- anything below             --
-- this unless you            --
-- know what you are doing    --
--------------------------------


--// Dependecies \\--
local DataStoreService = game:GetService("DataStoreService")
local currentDatastore = DataStoreService:GetDataStore(keyCode)
local moduleFunctions = require(script.Parent)
--//______________\\--



local function saveUser(player, isLeaving)
	
	
	local playerKey = "Key_CODE"..player.UserId
	local currentUpdatedData = moduleFunctions.GetCurrentUsers()[tostring(player.UserId)]
	
	local success, err = pcall(function()
		currentDatastore:UpdateAsync(playerKey, function(oldValue)
			
			if currentUpdatedData ~= nil then
				return currentUpdatedData
			else
				return oldValue
			end
			
		end)
	end)
	
	
	if success then
		if actionsFeedback then warn("Saved user data!") end
	end

	if isLeaving then		
		moduleFunctions.SetCurrentUsers(player.UserId, nil)
		if actionsFeedback then warn(player.Name.." left the game!") end
	end

end

local function loadUser(player)
	local playerKey = "Key_CODE"..player.UserId

	local success, err = pcall(function()
		local userData = currentDatastore:GetAsync(playerKey)

		if userData == nil then
			--First time playing the game
			if actionsFeedback then warn(player.Name.." is playing the game for the first time!") end
			moduleFunctions.SetCurrentUsers(player.UserId, your_schema)
		else
			--Check if user has all parameters
			for indexName, indexValue in pairs(your_schema)do

				local userParameter = userData[indexName]
				if userParameter == nil or typeof(userParameter) ~= typeof(your_schema[indexName]) then
					--First time having this parameter
					userData[indexName] = your_schema[indexName]
				end

			end

			--Get his data into the current users
			moduleFunctions.SetCurrentUsers(player.UserId, userData)

		end
	end)

	--Display the error on console
	if err then
		warn(err)
	end	
end

game.Players.PlayerAdded:Connect(function(player)

	loadUser(player)

end)

game.Players.PlayerRemoving:Connect(function(player)
		
	saveUser(player, true)

end)