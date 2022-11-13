local globals = require(game:GetService("ReplicatedStorage").Globals)
local purchasePrompt = require(game:GetService("ReplicatedStorage").Utilites.PurchasePrompt)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local marketPlaceGui = plrGui:WaitForChild("Market")
local mainFrame = marketPlaceGui.Market
local scrollingFrameList: ScrollingFrame = mainFrame.ScrollingFrameListMarket
local scrollingFrameMarket = mainFrame.ScrollingFrameMarket

local module = {}
function module.LoadModule()
    scrollingFrameList.MouseEnter:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(0,0,0.216,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)

    scrollingFrameList.MouseLeave:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(-.1,0,0.216,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)

    local newPrompt = purchasePrompt.prompt.new()
    newPrompt:PromptPurchase("ABCKD", "Hamburger", 10000, "Food")
end
return module