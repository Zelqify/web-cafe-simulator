local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages:WaitForChild("Knit"))

local VisualEffectsController = Knit.CreateController {Name = "VisualEffectsController"}

-- // Effects

VisualEffectsController.FadeInOutDuration = 0.3

-- // Variables

local Player
local LoadFrame 

function VisualEffectsController:KnitInit()
	-- Knit init
end

function VisualEffectsController:KnitStart()
	print("VisualEffectsController has been started")
	Player = game.Players.LocalPlayer
	LoadFrame = Player.PlayerGui:WaitForChild("VisualEffectsUI"):WaitForChild("Frame")
end

function VisualEffectsController:PlayLoadEffect(duration)
	TweenService:Create(LoadFrame, TweenInfo.new(VisualEffectsController.FadeInOutDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {["BackgroundTransparency"] = 0}):Play()
	wait(duration)
	TweenService:Create(LoadFrame, TweenInfo.new(VisualEffectsController.FadeInOutDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {["BackgroundTransparency"] = 1}):Play()
end


return VisualEffectsController