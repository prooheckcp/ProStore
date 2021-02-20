--//Hold user data\\--

local currentUsers = {}
local usersCoroutines = {}
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

return module