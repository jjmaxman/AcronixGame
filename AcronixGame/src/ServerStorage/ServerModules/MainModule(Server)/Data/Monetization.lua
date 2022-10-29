local globals = require(game:GetService("ReplicatedStorage").Globals)
local utilities = require(game:GetService("ReplicatedStorage").Utilites.UsefulFunctions)
local data = require(game:GetService("ReplicatedStorage").Utilites.Data)

local module = {}
function module.LoadModule()
	globals.MarketPlaceService.ProcessReceipt = function(receipt)
		local plr = globals.Players:GetPlayerByUserId(receipt.PlayerId)
		local productId = receipt.ProductId
		local plrData = plr:WaitForChild("PlayerData")
		local rubles = plrData:WaitForChild("Rubles")
		
		for name, dictData in pairs(data.DevProductIds) do
			if dictData.ID == productId then
				rubles.Value += dictData.Value
				return Enum.ProductPurchaseDecision.PurchaseGranted
			end
		end
		
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
end
return module
