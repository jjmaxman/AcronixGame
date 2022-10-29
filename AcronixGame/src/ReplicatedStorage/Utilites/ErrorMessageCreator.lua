local globals = require(game:GetService("ReplicatedStorage").Globals)

local module = {}
module.CreateErrorMessage = function(plrToDisplayTo, msg: string, timeToDisplay: number)
	task.spawn(function()
		local textLabel = Instance.new("TextLabel")
		textLabel.AnchorPoint = Vector2.new(0, 1)
		textLabel.Text = msg
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.Code
		textLabel.TextSize = 18
		textLabel.TextColor3 = Color3.fromRGB(255,0,0)
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Size = UDim2.new(.25,0,.075,0)

		textLabel.Parent = plrToDisplayTo.PlayerGui.ErrorMessages

		local tween = globals.TweenService:Create(textLabel, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0,false,0), {TextTransparency = 1})

		task.wait(timeToDisplay)

		tween:Play()

		tween.Completed:Connect(function()
			textLabel:Destroy()
			textLabel = nil
			tween = nil
		end)
	end)
end
return module
