-- Datastore library developed by Prooheckcp at
-- 02/19/2021
-- 

--Settings--

--The current code being used for the server
local keyCode = "keyuwuOwO"

--If Roblox Studio is allowed to save player data
local saveOnStudio = true

--If the console should print all changes
local actionsFeedback = true

--How often does the server auto save? (Default: every 3 minutes)
local autoSave = 3
------------

-- This is an example of a schema
-- Change it to your needs

local your_schema = {

	["Points"] = 0,
	["Coins"] = 10,
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
local RunService = game:GetService("RunService")
--//______________\\--


local function saveUser(player, isLeaving)
	
	
	local playerKey = "Key_CODE"..player.UserId
	local currentUpdatedData = moduleFunctions.GetCurrentUsers()[tostring(player.UserId)]
	
	if RunService:IsStudio() and saveOnStudio then
		
		print("Saving on Studio")
		
		currentDatastore:SetAsync(playerKey, currentUpdatedData)
		
		if isLeaving then		
			moduleFunctions.SetCurrentUsers(player.UserId, nil)
			if actionsFeedback then warn(player.Name.." left the game!") end
		end		
		
	else
		
		local userData = currentDatastore:GetAsync(playerKey)
		
		if userData ~= nil then
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
		else
			
			local success, err = pcall(function()
				currentDatastore:SetAsync(playerKey, currentUpdatedData)
			end)
			
			if success then
				if actionsFeedback then warn("Saved user data!") end
			end
			
		end
		

		if isLeaving then		
			moduleFunctions.SetCurrentUsers(player.UserId, nil)
			if actionsFeedback then warn(player.Name.." left the game!") end
		end		
		
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


--//Coroutines\\--
local usersCoroutines = {}

local updateUser = function(player)
	
	print(player)
	
	local minutesToWait = math.floor(autoSave * 60)

	while wait(minutesToWait) do

		if actionsFeedback then warn("Saved "..player.Name.." data!") end
		saveUser(player, false)
	end

end
--//___________\\--

--//Events\\--

game.Players.PlayerAdded:Connect(function(player)

	loadUser(player)
	usersCoroutines[tostring(player.UserId)] = coroutine.create(updateUser)
	
	coroutine.resume(usersCoroutines[tostring(player.UserId)], player)

end)

game.Players.PlayerRemoving:Connect(function(player)
	
	usersCoroutines[tostring(player.UserId)] = nil
	
	saveUser(player, true)
	

end)
--//_______\\--

