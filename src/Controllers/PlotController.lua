
-- // Services
local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserDataService

-- // Knit

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local PlotController = Knit.CreateController {Name = "PlotController"}

-- // Configurable Variables

local allowPlotLoading = true
local globalTweenDuration = 1
local globalTweenInfo = TweenInfo.new(globalTweenDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

-- // Initial Variables

local PlotService

local Player

local PlotLoaderFrame

function PlotController:KnitInit()
end

function PlotController:KnitStart()
    Player = game.Players.LocalPlayer
    PlotLoaderFrame = Player.PlayerGui:WaitForChild("UI"):WaitForChild("PlotLoader"):WaitForChild("LoaderFrame")
    UserDataService = Knit.GetService("UserDataService")
    print("PlotController has been successfully started.")

    UserDataService.getData:Connect(function(t)
        local Saves = t["Saves"]
        if #Saves == 0 then
            PlotLoaderFrame.TextLabel.Text = "You don't have any saved plots!"
        end
    end)
end

local function Tween(o,t)
    return TweenService:Create(o, globalTweenInfo, t)
end

function PlotController:selectPlot(Plot : any)
    local Saves = UserDataService.getData:Fire()
    print(Saves)
    PlotLoaderFrame.Parent.Position = UDim2.new(0.5, 0,1.5, 0)
    PlotLoaderFrame.Visible = true
    Tween(PlotLoaderFrame.Parent,{["Position"] = UDim2.new(0.5,0,0.5,0)}):Play()
    PlotLoaderFrame.CreateNewPlotButton.MouseButton1Up:Connect(function()
        UserDataService.registerPlot:Fire()
    end)
end

return PlotController