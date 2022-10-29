local globals = require(game:GetService("ReplicatedStorage").Globals)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local mainButton = plrGui:WaitForChild('Menu').Settings
local mainFrame = plrGui:WaitForChild('Settings').MainFrame.Keybinds
local keyBinds = plr:WaitForChild('KeyBinds')
local errorMessageCreator = require(globals.ErrorMessageCreator)

local module = {}
module.LoadModule = function()
	task.spawn(function()
		for _, keyBind in ipairs(keyBinds:GetChildren()) do
			local newTemplate = globals.KeyBindTemplates:Clone()
			newTemplate.Name = keyBind.Name
			newTemplate.Value.Value = keyBind.Value
			newTemplate.ActionName.Text = keyBind.Name
			newTemplate.KeyBind.Text = keyBind.Value

			local storedKeyBind = keyBind.Value
			local listner

			newTemplate.KeyBind.MouseButton1Click:Connect(function()
				newTemplate.KeyBind.Text = "..."
				listner = globals.UserInputService.InputBegan:Connect(function(input, gameProccessedEvent)
					if not gameProccessedEvent then
						if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Return then
							globals.ChangeKeyBind:FireServer(keyBind.Name, input.KeyCode.Name)
						elseif input.KeyCode == Enum.KeyCode.Return then
							newTemplate.KeyBind.Text = keyBind.Value
						end
					end
					listner:Disconnect()
				end)
			end)
			
			keyBind.Changed:Connect(function(newVal)
				newTemplate.Value.Value = newVal
				newTemplate.KeyBind.Text = newVal
			end)

			newTemplate.Parent = mainFrame
		end
	end)

	globals.ChangeKeyBind.OnClientEvent:Connect(function(success: boolean, keyBind: string, key: string, errorMsg: string)
		local frame = mainFrame:FindFirstChild(keyBind)

		frame.Value.Value = key
		frame.KeyBind.Text = key
		
		if success == false and errorMsg == "Matching Keys" then
			errorMessageCreator.CreateErrorMessage(plr, "You have two Keybinds with matching keys.", 5)
		elseif success == false and errorMsg == "Reserved Keybind" then
			errorMessageCreator.CreateErrorMessage(plr, "You attempted to switch your "..keyBind.." keybind to a reserved key.", 5)
		end
	end)
end
return module
