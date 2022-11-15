local plr = game.Players.LocalPlayer
local remote = game.ReplicatedStorage.Remotes.MarketPlaceRemotes.ManipulateMarketData
local globals = require(game:GetService("ReplicatedStorage").Globals)

local module = {}
module.prompt = {}
local openPrompt = false

module.prompt.__index = module.prompt
module.prompt.PurchasePrompt = globals.PurchasePrompt
module.prompt.NotEnoughPrompt = globals.NotEnoughPrompt
module.prompt.PurchaseResultPrompt = globals.PurchaseResultPrompt
function module.new()
    return setmetatable({}, module.prompt)
end

function module.prompt:PromptPurchase(key, item, price)
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
                local result = remote:InvokeServer("Purchase", {["Key"] = key, ["Item"] = item})
                MemoryManagement(connections)
                gui:Destroy()
                local resultUi = self.PurchaseResultPrompt:Clone()
                
                local buttonConnection = resultUi.MainFrame.OkButton.MouseButton1Click:Connect(function()
                    resultUi:Destroy()
                    buttonConnection:Disconnect()
                end)
                resultUi.Parent = plr.PlayerGui
                if result then
                    resultUi.MainFrame.InfoLabel.Text = "Your purchase of "..item.." succeeded!"
                    return true
                else
                    resultUi.MainFrame.InfoLabel.Text = "Your purchase of "..item.." failed. Try to purchase this item again, or send a report in our communications links."
                    return false
                end
            end)

            connections["cancelButtonConnection"] = mainFrame.CancelButton.MouseButton1Click:Connect(function()
                MemoryManagement(connections)
                gui:Destroy()
                return false
            end)

            connections["closeButton"] = mainFrame.CloseButton.MouseButton1Click:Connect(function()
                MemoryManagement(connections)
                gui:Destroy()
                return false
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