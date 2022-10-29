local globals = require(game:GetService("ReplicatedStorage").Globals)
local serverScriptService = game:GetService("ServerScriptService")
local serverScript = serverScriptService.Server
local datastore2 = require(serverScript.DataStore2)
local keyBindsFolder = globals.ServerStorage:WaitForChild('KeyBinds')
local settingsFolder = globals.ServerStorage:WaitForChild("Settings")

--Extra data saving function--
local function GrabData(plr, data, folderToSaveTo: Folder)
	task.spawn(function()
		for name, value in pairs(data) do
			local currentValue = folderToSaveTo:FindFirstChild(name)
			currentValue.Value = value
		end
	end)
end

local function SaveData(plr, folder: Folder, dataStoreKey)
	task.spawn(function()
		for _, v in ipairs(folder:GetChildren()) do
			v.Changed:Connect(function()
				local data = {}
				for _, value in pairs(folder:GetChildren()) do
					data[value.Name] = value.Value
				end
				dataStoreKey:Set(data) 
			end)
		end
	end)
end

local function SaveGeneralSettings(plr, settingsFolder, dataStoreKey)
	task.spawn(function()
		local data = {}
		
		for _, folder in ipairs(settingsFolder:GetChildren()) do
			local values = {}
			for _, value in ipairs(folder:GetChildren()) do
				values[value.Name] = value.Value
			end
			data[folder.Name] = values
		end
		
		dataStoreKey:Set(data)
	end)
end

local function DetectGeneralSettingsChanges(plr,settingsFolder, dataStoreKey)
	task.spawn(function()
		for _, folder in ipairs(settingsFolder:GetChildren()) do
			for _, values in ipairs(folder:GetChildren()) do
				values.Changed:Connect(function()
					SaveGeneralSettings(plr, settingsFolder,dataStoreKey)
				end)
			end
		end
	end)
end

local function GrabGeneralSettings(savedSettings, newSettings)
	for folderName, value in pairs(savedSettings:Get()) do
		local folder = newSettings:FindFirstChild(folderName)
		for i, v in pairs(value) do
			local setting = folder:FindFirstChild(i)
			setting.Value = v
		end
	end
end

local module = {}
module.LoadModule = function()
	datastore2.Combine("MasterKey","PlayerData", "KeyBinds", "Settings", "Inventory")
	globals.Players.PlayerAdded:Connect(function(plr)
		local playerData = Instance.new("Folder")
		playerData.Name = "PlayerData"
		playerData.Parent = plr

		local rubles = Instance.new("IntValue")
		rubles.Name = "Rubles"
		rubles.Parent = playerData

		local kills = Instance.new("IntValue")
		kills.Name = "Kills"
		kills.Parent = playerData

		local deaths = Instance.new("IntValue")
		deaths.Name = "Deaths"
		deaths.Parent = playerData

		local roundsFired = Instance.new("IntValue")
		roundsFired.Name = "RoundsFired"
		roundsFired.Parent = playerData

		local inventoryFolder = Instance.new("Folder")
		inventoryFolder.Name = "Inventory"
		inventoryFolder.Parent = plr

		local newKeyBinds = keyBindsFolder:Clone()
		newKeyBinds.Parent = plr
		
		local newSettings = settingsFolder:Clone()
		newSettings.Parent = plr

		--//Grabs Data\\--
		local savedPlayerData = datastore2("PlayerData", plr)
		local savedKeyBinds = datastore2("KeyBinds", plr)
		local savedInventory = datastore2("Inventory", plr)
		local savedSettings = datastore2("Settings", plr)

		if savedPlayerData:Get() then
			GrabData(plr, savedPlayerData:Get(), playerData)
		end

		if savedKeyBinds:Get() then
			GrabData(plr, savedKeyBinds:Get(), newKeyBinds)
		end
		
		if savedSettings:Get() then
			GrabGeneralSettings(savedSettings, newSettings)
		end

		if savedInventory:Get() then
			task.spawn(function()
				for item, info in pairs(savedInventory:Get()) do

				end
			end)
		end

		--//Save Data\\--
		SaveData(plr, playerData, savedPlayerData)--Player Data Saving
		SaveData(plr, newKeyBinds, savedKeyBinds)--Keybinds Saving
		DetectGeneralSettingsChanges(plr, newSettings, savedSettings)--General Settings Saving
	end)
end
return module
