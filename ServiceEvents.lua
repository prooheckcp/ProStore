-- Datastore library developed by Prooheckcp at
-- 02/19/2021
-- Version: 1.1

--Settings--
local projectSettings = require(script.Parent.Settings)

local projectSettings = require(script.Parent.Settings)
local keyCode = projectSettings.Keycode
local saveOnStudio = projectSettings.SaveOnStudio
local actionsFeedback = projectSettings.actionsFeedback
local autoSave = projectSettings.autoSave
local your_schema = projectSettings.schema

------------


--------------------------------
-- Do not touch               --
-- anything below             --
-- unless you know            --
-- what you are doing         --
--------------------------------


--// Dependecies \\--
local DataStoreService = game:GetService("DataStoreService")
local currentDatastore = DataStoreService:GetDataStore(keyCode)
local moduleFunctions = require(script.Parent)
local RunService = game:GetService("RunService")
local proStore = require(script.Parent)
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
		
	elseif not RunService:IsStudio() then
		
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
	local userData
	
	local success, err = pcall(function()
		userData = currentDatastore:GetAsync(playerKey)

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
	else
		return userData
	end	
	
	
	
end


--//Coroutines\\--
local usersCoroutines = {}

local updateUser = function(player)
	
	
	
	local minutesToWait = math.floor(autoSave * 60)

	while wait(minutesToWait) do
		
		
		local foundPlayer = false
		for _, p in pairs(game.Players:GetPlayers())do
			if p == player then
				foundPlayer = true
			end
		end
		
		if not foundPlayer then
			if actionsFeedback then warn("This player is no longer here") end
			break
		end
		
		print("called", player.Name)
		if actionsFeedback then warn("Saved "..player.Name.." data!") end
		saveUser(player, false)
	end

end
--//___________\\--

--//Events\\--

script.Parent.ForcedSave.Event:Connect(function(player)
	saveUser(player, false)
end)

game.Players.PlayerAdded:Connect(function(player)

	local userData = loadUser(player)
	usersCoroutines[tostring(player.UserId)] = coroutine.create(updateUser)
	
	coroutine.resume(usersCoroutines[tostring(player.UserId)], player)
	
	--play the events 
	for _, method in pairs(proStore.GetCurrentStartEvents()) do
		method(player, userData)
	end

end)

game.Players.PlayerRemoving:Connect(function(player)
	
	usersCoroutines[tostring(player.UserId)] = nil
	
	saveUser(player, true)
	

end)
--//_______\\--

