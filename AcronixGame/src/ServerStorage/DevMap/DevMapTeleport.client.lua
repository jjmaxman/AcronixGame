local TeleportService = game:GetService("TeleportService")

local gameID = 7490494745

local player = game.Players.LocalPlayer

local function onClick()
	if player then
		TeleportService:Teleport (gameID, player)
	end
end

script.parent.MouseButton1Click:Connect(onClick)
