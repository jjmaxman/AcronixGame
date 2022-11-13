local plr = game.Players.LocalPlayer
local remote = game.ReplicatedStorage.Remotes.MarketPlaceRemotes.ManipulateMarketData

local module = {}
module.prompt = {}
local openPrompt = false

module.prompt.__index = module.prompt
module.prompt.PurchasePrompt = script.PurchasePrompt
module.prompt.NotEnoughPrompt = script.NotEnoughPrompt
function module.prompt.new()
    return setmetatable({}, module.prompt)
end

function module.prompt:PromptPurchase(key, item, price, itemType)
    if not openPrompt then
        openPrompt = true
        local playerData = plr:WaitForChild("PlayerData")
        local rubles = playerData:WaitForChild("Rubles")

        local MemoryManagement = function(connections)
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end

            openPrompt = false
        end

        if price <= rubles.Value then
            local gui = self.PurchasePrompt:Clone()
            local mainFrame = gui.MainFrame
            mainFrame.InfoLabel.Text = "Buy "..item.." for ₽"..price.."?"
            local connections = {}

            connections["buyButtonConnection"] = mainFrame.BuyButton.MouseButton1Click:Connect(function()
                remote:InvokeServer("Purchase", {["Key"] = key, ["ItemType"] = itemType})
                MemoryManagement(connections)
                gui:Destroy()
            end)

            connections["cancelButtonConnection"] = mainFrame.CancelButton.MouseButton1Click:Connect(function()
                MemoryManagement(connections)
                gui:Destroy()
            end)

            connections["closeButton"] = mainFrame.CloseButton.MouseButton1Click:Connect(function()
                MemoryManagement(connections)
                gui:Destroy()
            end)


            gui.Parent = plr.PlayerGui
        else
            local gui = self.NotEnoughPrompt:Clone()
            local mainFrame = gui.MainFrame
            
            local connections = {}

            connections["getRublesButton"] = mainFrame.GetRublesButton.MouseButton1Click:Connect(function()
                plr.PlayerGui.Store.Enabled = true
                plr.PlayerGui.Market.Enabled = false

                MemoryManagement(connections)
                gui:Destroy()
            end)

            gui.Parent = plr.PlayerGui
        end
        return
    end
end
return module