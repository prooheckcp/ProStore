--//Hold user data\\--

local currentUsers = {}
--//_______________\\--

local module = {
	GetCurrentUsers = function()
		return currentUsers
	end,
	SetCurrentUsers = function(index, info)
		currentUsers[tostring(index)] = info

	end,
	usersCoroutines = function(index)
		return currentUsers[tostring(index)]
	end
}

function module:Get(player, parameterName)
		
		local resultData = nil
		
		if player ~= nil then
			resultData = currentUsers[tostring(player.UserId)][parameterName]
		end
		
		return resultData
end

function module:Set(player, parameterName, info)
	
	currentUsers[tostring(player.UserId)][parameterName] = info
	
end

function module:Inc(player, parameterName, amount)
	
	local playerValue = currentUsers[tostring(player.UserId)][parameterName]
	
	if typeof(playerValue) == typeof(0) then
		currentUsers[tostring(player.UserId)][parameterName] = playerValue + amount
		return playerValue + amount
	else
		error("You cannot increment on non number types!")
		return false
	end
	
end

function module:Add(player, parameterName, item)
	
	
	local playerValue = currentUsers[tostring(player.UserId)][parameterName]
	
	if typeof(playerValue) ~= typeof({}) then
		error("You cannot add to non arrays!")
		return false
	else
		table.insert(playerValue, item)
		return playerValue
	end

	
end


function module:ForceSave(player)
	if player ~= nil then
		script.ForcedSave:Fire(player)
	end
end

return module