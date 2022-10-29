local globals = require(game:GetService("ReplicatedStorage").Globals)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local deploymentGui = plrGui:WaitForChild("Deployment")

local module = {}
module.LoadModule = function()
	for _, map in ipairs(globals.Maps:GetChildren()) do
		local newTemplate = globals.DeploymentTemplate:Clone()
		newTemplate.PlaceId.Value = map.Value
		newTemplate.Hover.Text = map.Name
		newTemplate.Parent = deploymentGui.ScrollingFrame
	end
end
return module
