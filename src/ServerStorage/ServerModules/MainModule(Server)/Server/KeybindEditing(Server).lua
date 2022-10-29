local globals = require(game:GetService("ReplicatedStorage").Globals)

local reservedKeys = {"Return", "Backspace", "Escape", "Space", "W", "A", "S", "D"}

local module = {}
module.LoadModule = function()
	globals.ChangeKeyBind.OnServerEvent:Connect(function(plr, keyBind, key)
		local keyBindsFolder = plr.KeyBinds
		local keyBindsInUse = {}
		if keyBindsFolder:FindFirstChild(keyBind) then
			--Prevents two keybinds from being the same--
			for _, KeyBind in ipairs(keyBindsFolder:GetChildren()) do
				table.insert(keyBindsInUse, KeyBind.Value)
			end
			
			local currentKeyBind = keyBindsFolder:FindFirstChild(keyBind)
			if not table.find(reservedKeys, key) and not table.find(keyBindsInUse, key) and Enum.KeyCode[key] ~= nil then
				currentKeyBind.Value = key
				globals.ChangeKeyBind:FireClient(plr, true, currentKeyBind.Name, key)
			elseif table.find(keyBindsInUse, key) then
				globals.ChangeKeyBind:FireClient(plr, false, currentKeyBind.Name, currentKeyBind.Value, "Matching Keys")
			elseif table.find(reservedKeys, key) then
				globals.ChangeKeyBind:FireClient(plr, false, currentKeyBind.Name, currentKeyBind.Value, "Reserved Keybind")
			end
		end
	end)
end
return module
