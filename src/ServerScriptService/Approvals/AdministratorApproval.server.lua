local rank = 253
local groupID = 12638142

game.Players.PlayerAdded:Connect(function(plr)
	if (plr:IsInGroup(groupID) and plr:GetRankInGroup(groupID) >= rank) then
		game.ServerStorage.DevMap:Clone().Parent = plr.PlayerGui:WaitForChild("Menu").HomeFrame.MapScrollingFrame
	end
end)