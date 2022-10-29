local globals = require(game:GetService("ReplicatedStorage").Globals)

local module = {}
module.LoadModule = function()
	globals.Players.PlayerAdded:Connect(function(plr)
		for _, gui in ipairs(globals.StarterGui:GetChildren()) do
			local newGui = gui:Clone()
			newGui.Parent = plr.PlayerGui
		end
	end)
end
return module
