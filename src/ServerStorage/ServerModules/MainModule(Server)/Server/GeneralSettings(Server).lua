local globals = require(game:GetService("ReplicatedStorage").Globals)

function FindSetting(settingsFolder, settingName)
		local found
		for _, values in ipairs(settingsFolder:GetChildren()) do
			if values:FindFirstChild(settingName) then
				found = values:FindFirstChild(settingName)
				break
			end
		end
		return found
end

local module = {}
module.LoadModule = function()
	globals.ChangeSettings.OnServerEvent:Connect(function(plr, settingName, Value)
		local settingsFolder = plr.Settings
		local setting = FindSetting(settingsFolder, settingName)
		
		if setting then
			if setting:IsA("BoolValue") then
				if Value == true or Value == false then
					setting.Value = Value
				end
			elseif setting:IsA("DoubleConstrainedValue") or setting:IsA("IntConstrainedValue") then
				if tonumber(Value) and setting:IsA("DoubleConstrainedValue") then
					setting.Value = tonumber(Value)
				elseif tonumber(Value) and setting:IsA("IntConstrainedValue") then
					local num = tonumber(Value)
					setting.Value = math.round(num)
				end
			end
		end
	end)
end
return module
