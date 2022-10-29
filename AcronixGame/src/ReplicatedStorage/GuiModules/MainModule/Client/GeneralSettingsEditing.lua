local globals = require(game:GetService("ReplicatedStorage").Globals)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local settingsUI = plrGui:WaitForChild("Settings")
local mainFrame = settingsUI.MainFrame
local general = mainFrame.General
local plrSettings = plr:WaitForChild("Settings")
local camSettings = plrSettings.Camera
local inputSettings = plrSettings.Inputs
local mouseSettings = plrSettings.Mouse


local function CreateConStrainedValueTemplate(value, Template ,LayoutOrder)
	local newTemplate = globals[Template]:Clone()
	local templateValue = newTemplate.Value
	templateValue.MaxValue = value.MaxValue
	templateValue.MinValue = value.MinValue
	templateValue.Value = value.Value
	newTemplate.SettingNameValue.Value = value.Name
	newTemplate.SettingName.Text = value.Name
	newTemplate.LayoutOrder = LayoutOrder + 1
	

	local sliderFrame = newTemplate.SliderFrame
	local slider = sliderFrame.SliderButton
	local sliderBackgroundFrame = sliderFrame.Frame
	local displayLabel = sliderFrame.DisplayLabel

	displayLabel.Text = tostring(value.Value)
	local x = value.Value/value.MaxValue
	slider.Position = UDim2.new(x,0,.5,0)
	sliderBackgroundFrame.Size = UDim2.new(x,0,1,0)
	
	value.Changed:Connect(function(newVal)
		templateValue.Value = newVal
	end)
	
	newTemplate.Parent = general
end

--When using this function, make sure you use a greater than the previous LayoutOrder by at least 2--
local createTemplates = function(plr, settingsFolder: Folder, LayoutOrder: number)
	task.spawn(function()
		local newSeperator = globals.SeperatorTemplate:Clone()
		newSeperator.Text = settingsFolder.Name
		newSeperator.LayoutOrder = LayoutOrder
		newSeperator.Parent = general
		
		for _, value in ipairs(settingsFolder:GetChildren()) do
			if value:IsA("BoolValue") then
				local newBoolTemplate = globals.BoolSettingsTemplate:Clone()
				newBoolTemplate.SettingName.Text = value.Name
				newBoolTemplate.Value.Value = value.Value
				newBoolTemplate.SettingNameValue.Value = value.Name
				newBoolTemplate.LayoutOrder = LayoutOrder + 1
				
				if newBoolTemplate.Value.Value == true then
					newBoolTemplate.BoolButton.TextLabel.Text = "On"
					newBoolTemplate.BoolButton.BackgroundColor3 = Color3.fromRGB(0,127,0)
				else
					newBoolTemplate.BoolButton.TextLabel.Text = "Off"
					newBoolTemplate.BoolButton.BackgroundColor3 = Color3.fromRGB(127,0,0)
				end
				
				value.Changed:Connect(function(newVal)
					newBoolTemplate.Value.Value = newVal
				end)
				
				newBoolTemplate.Parent = general
			elseif value:IsA("IntConstrainedValue") then
				CreateConStrainedValueTemplate(value, globals.ConstrainedIntSettingsTemplate.Name, LayoutOrder)
			elseif value:IsA("DoubleConstrainedValue") then
				CreateConStrainedValueTemplate(value, globals.ConstrainedDoubleSettingsTemplate.Name, LayoutOrder)
			end
		end
	end)
end

local module = {}
module.LoadModule = function()
	createTemplates(plr, inputSettings, 2)
	createTemplates(plr, camSettings, 4)
	createTemplates(plr, mouseSettings, 6)
end
return module
