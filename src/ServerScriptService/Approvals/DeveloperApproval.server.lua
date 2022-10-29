local rank = 254
local groupID = 12638142

game.Players.PlayerAdded:Connect(function(plr)
	if (plr:IsInGroup(groupID) and plr:GetRankInGroup(groupID) >= rank) then
		game.ServerStorage.AdminPanelFrame:Clone().Parent = plr.PlayerGui:WaitForChild("Menu")
	end
end)