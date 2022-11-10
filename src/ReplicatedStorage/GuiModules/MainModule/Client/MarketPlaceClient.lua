local globals = require(game:GetService("ReplicatedStorage").Globals)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local marketPlaceGui = plrGui:WaitForChild("Market")
local mainFrame = marketPlaceGui.MainFrame
local scrollingFrameList: ScrollingFrame = mainFrame.ScrollingFrameList
local scrollingFrameMarket = mainFrame.ScrollingFrameMarket

local module = {}
function module.LoadModule()
    scrollingFrameList.MouseEnter:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(0,0,0.181,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)

    scrollingFrameList.MouseLeave:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(-.1,0,.181,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)
end
return module