local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()

game:GetService("UserInputService").MouseIconEnabled = false

RunService.RenderStepped:Connect(function()
	script.Parent.Position = UDim2.new(0,mouse.X,0,mouse.Y)
end)