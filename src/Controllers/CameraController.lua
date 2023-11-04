local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages:WaitForChild("Knit"))

local CameraController = Knit.CreateController {Name = "CameraController"}

-- // Variables
CameraController.Target = game.Workspace.CameraList:WaitForChild("MenuCam")
CameraController.isOnTarget = true 

local Player
function CameraController:KnitInit()
	-- Knit init
end

function CameraController:KnitStart()
	print("CameraController has been started")
	RunService.RenderStepped:Connect(function()
		if self.isOnTarget == true then
			game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
			TweenService:Create(game.Workspace.CurrentCamera,TweenInfo.new(0.1,Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{["CFrame"] = self.Target.CFrame}):Play()
		else 
			game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		end
	end)
end

return CameraController