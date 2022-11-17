local globals = require(game:GetService("ReplicatedStorage").Globals)
local purchasePrompt = require(game:GetService("ReplicatedStorage").Utilites.PurchasePrompt)
local gameItems = require(game:GetService("ReplicatedStorage").ReplicatedGameData.GameItems)
local plr = globals.Players.LocalPlayer
local plrGui = plr.PlayerGui
local marketPlaceGui = plrGui:WaitForChild("Market")
local mainFrame = marketPlaceGui.Market
local scrollingFrameList: ScrollingFrame = mainFrame.ScrollingFrameListMarket
local scrollingFrameMarket = mainFrame.ScrollingFrameMarket
local openSideBarButton = ""


--//#region Functions\\--
--Garbage collection (Can I even call it this?? Might just call it memory management)--
local connections = {}

local function ManageMemory()
    for index, value in pairs(connections) do
        value:Disconnect()
    end
    connections = {}
end

--Creation functions--
local function CreateNewSubCatButtons(button, list: table)
    --[[for name, value in pairs(list) do --This might not get used depends how everything goes
        local newFrame = Instance.new("Frame")
        newFrame.Name = "SubCat"
        newFrame.Size
    end]]--
end

--//#endregion Functions\\--
local module = {}
function module.LoadModule()
    --Sidebar effects--
    scrollingFrameList.MouseEnter:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(0,0,0.216,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)

    scrollingFrameList.MouseLeave:Connect(function()
        scrollingFrameList:TweenPosition(UDim2.new(-.1,0,0.216,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .5, true)
    end)

    --Sidebar buttons--
    for _, button in ipairs(scrollingFrameList:GetChildren()) do
        if button:IsA("GuiButton") then
            print(gameItems[button.Name])
            button.MouseButton1Click:Connect(function()
            end)
        end
    end
end
return module