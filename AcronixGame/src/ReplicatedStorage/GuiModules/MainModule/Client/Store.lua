local globals = require(game:GetService("ReplicatedStorage").Globals)
local data = require(game:GetService("ReplicatedStorage").Utilites.Data)
local usefulFunctions = require(game:GetService("ReplicatedStorage").Utilites.UsefulFunctions)

local plr = globals.Players.LocalPlayer
local parent = plr.PlayerGui:WaitForChild("Store").Currency

local module = {}
function module.LoadModule()
	for name, data in pairs(data.DevProductIds) do
		local newTemplate = globals.DevProductTemplate:Clone()
		newTemplate.LayoutOrder = data.Value
		newTemplate.ProductId.Value = data.ID
		local hoverLabel = newTemplate.Hover
		hoverLabel.Text = name
		newTemplate.Parent = parent
	end
end
return module
