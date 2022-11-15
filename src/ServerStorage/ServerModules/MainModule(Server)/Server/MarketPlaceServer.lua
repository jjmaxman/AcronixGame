local globals = require(game:GetService("ReplicatedStorage").Globals)
local timeModule = require(game:GetService("ReplicatedStorage").Utilites.TimeModule)
local gameSettings = game:GetService("ServerStorage").GameSettings
local tax = gameSettings.Tax
local itemExpiration = gameSettings.ItemExpiration

local memoryStores = {"AS Val", "M4A1", "G36", "M110", "PKM", "AK47", "AK74", "Kar98k"}

task.spawn(function()
	for _, store in pairs(memoryStores) do
		globals.MemoryStoreService:GetSortedMap(store)
	end
end)

--Memory Store Utilities (Might make this it's own seperate module if I have to use memorystore service elsewhere)--
local function GetMemoryStoreData(store, numOfRequestedItems, lowerBound)
	local memoryStore = globals.MemoryStoreService:GetSortedMap(store)

	local data
	local success, errorMessage = pcall(function()
		data = memoryStore:GetRangeAsync(Enum.SortDirection.Descending, numOfRequestedItems, lowerBound)
	end)

	if success then
		return data
	else
		return false
	end
end

local function SetMemoryStoreData(store, dataToSave)
	local memoryStore = globals.MemoryStoreService:GetSortedMap(store)

	local success, errorMessage = pcall(function()
		memoryStore:SetAsync(dataToSave.Key, dataToSave.Value, timeModule.DaysToSeconds(itemExpiration.Value))
	end)

	if success then
		return true
	else
		return false
	end
end

local function RemoveKeyFromStore(store, key)
	local memorystore = globals.MemoryStoreService:GetSortedMap(store)

	local success, errorMessage = pcall(function()
		memorystore:RemoveAsync(key)
	end)

	if success then 
		return true
	else
		return false
	end

end

local function GetValueFromStore(store, key)
	local memoryStore = globals.MemoryStoreService:GetSortedMap(store)

	local data
	local success, errorMessage = pcall(function()
		data = memoryStore:GetAsync(key)
	end)

	if success then
		return data
	else 
		return false
	end
end



local module = {}
function module.LoadModule()
	globals.ManipulateMarketData.OnServerInvoke = function(plr, type, data)
		local plrData = plr.PlayerData
		if table.find(memoryStores, data.Key) then
			if type == "Purchase" then
				local item = GetValueFromStore(data.Item, data.Key)
				if item ~= false then
					if item.value.Price >= plrData.Rubles.Value then
                        if RemoveKeyFromStore(data.Item, data.Key) then
                            return true
                        else
                            return false
                        end
					end
				end

            elseif type == "Sell" then

			end
        else
            warn("Client input was invalid!")
            return false
		end
	end
end
return module