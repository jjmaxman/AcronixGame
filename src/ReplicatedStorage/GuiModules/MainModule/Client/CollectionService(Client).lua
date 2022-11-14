--TODO: idk atm lmao
local globals = require(game:GetService('ReplicatedStorage').Globals)
local errorMsgCreator = require(globals.ErrorMessageCreator)
local useFulFunctions = require(game:GetService('ReplicatedStorage').Utilites.UsefulFunctions)
local data = require(game:GetService("ReplicatedStorage").Utilites.Data)
local purchasePrompt = require(game:GetService("ReplicatedStorage").Utilites.PurchasePrompt)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local menu = plrGui:WaitForChild("Menu")
local mouse = plr:GetMouse()

local functions = {
	["SetUpBoolSettings"] = function(frame)
		local boolButton = frame.BoolButton
		local value = frame.Value
		local settingName = frame.SettingNameValue

		value.Changed:Connect(function(newVal)
			if newVal then
				boolButton.BackgroundColor3 = Color3.fromRGB(0,127,0)
				boolButton.TextLabel.Text = "On"
			else
				boolButton.BackgroundColor3 = Color3.fromRGB(127,0,0)
				boolButton.TextLabel.Text = "Off"
			end
		end)
		
		boolButton.MouseButton1Click:Connect(function()
			globals.ChangeSettings:FireServer(settingName.Value, not value.Value)
		end)

		value.Changed:Connect(function(newVal)
			if newVal == true then
				boolButton.BackgroundColor3 = Color3.fromRGB(0,127,0)
				boolButton.TextLabel.Text = "On"
			else
				boolButton.BackgroundColor3 = Color3.fromRGB(127,0,0)
				boolButton.TextLabel.Text = "Off"
			end
		end)
	end,

	["SetUpConstrainedValueSetting"] = function(frame, isDouble)
		local sliderFrame = frame.SliderFrame
		local settingNameValue = frame.SettingNameValue
		local value = frame.Value
		local maxValue = value.MaxValue
		local sliderBackground = sliderFrame.Frame
		local sliderButton: TextButton = sliderFrame.SliderButton
		local displayLabel: TextBox = sliderFrame.DisplayLabel
		
		value.Changed:Connect(function(newVal)
			local x = newVal/maxValue
			
			displayLabel.Text = tostring(newVal)
			sliderButton.Position = UDim2.new(x,0,.5,0)
			sliderBackground.Size = UDim2.new(x,0,1,0)
		end)

		displayLabel.FocusLost:Connect(function(enterPressed)
			if enterPressed then
				if tonumber(displayLabel.Text) then
					local x = tonumber(displayLabel.Text)/maxValue

					if x > 1 then
						x = 1
					elseif x < 0 then
						x = globals.Math.Round(value.MinValue/ maxValue, 2)
						if isDouble then
							displayLabel.Text = tostring(value.MinValue)
						else
							displayLabel.Text = tostring(value.MinValue)
						end
					end

					globals.ChangeSettings:FireServer(settingNameValue.Value, tonumber(displayLabel.Text))
					sliderButton.Position = UDim2.new(x,0,.5,0)
					sliderBackground.Size = UDim2.new(x,0,1,0)
				end
			end
		end)

		local focused

		sliderButton.MouseButton1Down:Connect(function()
			if focused ~= nil then
				focused:Disconnect()
			end

			focused = sliderFrame.MouseMoved:Connect(function(x, y)
				local scale = (x - sliderFrame.AbsolutePosition.X)/(sliderFrame.AbsoluteSize.X)
				if scale < 1 then
					sliderButton.Position = UDim2.new(scale,0,.5,0)
					sliderBackground.Size = UDim2.new(scale,0,1,0)
					if isDouble then
						displayLabel.Text = tostring(globals.Math.Round(scale * maxValue,2))
					else
						displayLabel.Text = tostring(math.round(scale * maxValue))
					end
				end
			end)

			sliderButton.MouseButton1Up:Connect(function()
				if focused then
					focused:Disconnect()
					focused = nil
					globals.ChangeSettings:FireServer(settingNameValue.Value, tonumber(displayLabel.Text))
				end
			end)
		end)
	end,

	["SetUpButtons"] = function(button)
		if button:IsA("GuiButton") then
			--[[button.MouseEnter:Connect(function()
				globals.Hover:Play()
			end)]]--

			button.MouseButton1Click:Connect(function()
				globals.Click:Play()
			end)
		end
	end,

	["SetUpBigMenuButtons"] = function(button: TextButton)
		local hoverLabel = useFulFunctions.FindFirstChildWithPartialString(button, "Hover")
		button.MouseEnter:Connect(function()
			hoverLabel:TweenSize(UDim2.new(1,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local textTween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0,false), {TextTransparency = 0})
			textTween:Play()
		end)

		button.MouseLeave:Connect(function()
			hoverLabel:TweenSize(UDim2.new(0,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local textTween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0,false), {TextTransparency = 1})
			textTween:Play()
		end)
		
		button.MouseButton1Click:Connect(function()
			local correspondingGui = plrGui:FindFirstChild(button.Name)
			if correspondingGui then
				correspondingGui.Enabled = true
				menu.Enabled = false
			else
				errorMsgCreator.CreateErrorMessage(plr, "This button has not been initialized. ["..button.Name.."]", 5)
			end
		end)

	end,

	["SetupSmallMenuButtons"] = function(button)
		local respectiveGui = plr.PlayerGui:FindFirstChild(button.Name)
		button.MouseButton1Click:Connect(function()
			if respectiveGui then
				respectiveGui.Enabled = true
				menu.Enabled = false
			else
				errorMsgCreator.CreateErrorMessage(plr, "There is currently nothing associated with this button. ["..button.Name.."]", 5)
			end
		end)
	end,

	["SetUpMenuButtons"] = function(button)
		button.MouseEnter:Connect(function()
			globals.Hover:Play()
		end)

		button.MouseButton1Click:Connect(function()
			globals.Click:Play()
		end)
	end,
	
	["BackButtonSetup"] = function(button)
		button.MouseButton1Click:Connect(function()
			menu.Enabled = true
			button:FindFirstAncestorWhichIsA("ScreenGui").Enabled = false
		end)
	end,
	
	["DeploymentButtonSetup"] = function(button)
		local hoverLabel:TextLabel = button.Hover
		button.MouseEnter:Connect(function()
			globals.Hover:Play()
			hoverLabel:TweenSize(UDim2.new(1,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local tween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0})
			tween:Play()
		end)
		
		button.MouseLeave:Connect(function()
			hoverLabel:TweenSize(UDim2.new(0,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local tween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1})
			tween:Play()
		end)
		
		button.MouseButton1Click:Connect(function()
			globals.Click:Play()
			globals.TeleportService:Teleport(button.PlaceId.Value, plr)
		end)
	end,
	
	["DevProductButtonSetup"] = function(button)
		local hoverLabel = button.Hover
		local productId = button.ProductId
		
		button.MouseEnter:Connect(function()
			hoverLabel:TweenSize(UDim2.new(1,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local textTween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0,false), {TextTransparency = 0})
			textTween:Play()
		end)

		button.MouseLeave:Connect(function()
			hoverLabel:TweenSize(UDim2.new(0,0,.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5,true)
			local textTween = globals.TweenService:Create(hoverLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0,false), {TextTransparency = 1})
			textTween:Play()
		end)
		
		button.MouseButton1Click:Connect(function()
			globals.MarketPlaceService:PromptProductPurchase(plr, productId.Value)
		end)
	end,

	["MarketPlaceButtonSetup"] = function(button)
		local categoryLabel = button:WaitForChild('Category')
		local currencyLabel = button:WaitForChild('Currency')
		local itemLabel = button:WaitForChild('Item')
		local data = button:WaitForChild('Data')

		button.MouseButton1Click:Connect(function()
			local newPrompt = purchasePrompt.new()
			newPrompt:PromptPurchase(data.Key.Value, data.Item.Value, data.Price.Value)
		end)
	end
}

local InitializeTag = function(tag, tagFunction)
	task.spawn(function()
		for _, instance in ipairs(globals.CollectionService:GetTagged(tag)) do
			if tag == "ConstrainedDoubleSettingFrame" then
				functions[tagFunction](instance, true)
			else
				functions[tagFunction](instance)
			end
		end
	end)
	
	globals.CollectionService:GetInstanceAddedSignal(tag):Connect(functions[tagFunction])
end

local module = {}
module.LoadModule = function()
	--Button--
	InitializeTag("Button", "SetUpButtons")
	--ConstrainedIntSettingFrame--
	InitializeTag("ConstrainedIntSettingFrame", "SetUpConstrainedValueSetting")
	--ConstrainedDoubleSettingFrame--
	InitializeTag("ConstrainedDoubleSettingFrame", "SetUpConstrainedValueSetting")
	--BoolSettingFrame--
	InitializeTag("BoolSettingFrame", "SetUpBoolSettings")
	--Menu Big Buttons--
	InitializeTag("MenuBigButtons", "SetUpBigMenuButtons")
	--Menu Small Buttons--
	InitializeTag("MenuSmallButtons", "SetupSmallMenuButtons")
	--All Menu Buttons--
	InitializeTag("MenuButton", "SetUpMenuButtons")
	--Back Buttons--
	InitializeTag("MainBackButtons", "BackButtonSetup")
	--Deployment Buttons--
	InitializeTag("DeploymentButton", "DeploymentButtonSetup")
	--DevProduct Buttons--
	InitializeTag("DevProductButtonSetup", "DevProductButtonSetup")
	--MarketPlace Buttons--
	InitializeTag("MarketPlaceItemButton", "MarketPlaceButtonSetup")
end
return module