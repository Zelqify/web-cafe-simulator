
-- // Services
local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

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
    print("PlotController has been successfully started.")
end

local function Tween(o,t)
    return TweenService:Create(o, globalTweenInfo, t)
end

function PlotController:selectPlot(Plot : any)
    PlotLoaderFrame.Parent.Position = UDim2.new(0.5, 0,1.5, 0)
    PlotLoaderFrame.Visible = true
    Tween(PlotLoaderFrame.Parent,{["Position"] = UDim2.new(0.5,0,0.5,0)}):Play()
end

return PlotController