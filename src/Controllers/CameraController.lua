local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
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
			game.Workspace.CurrentCamera.CFrame = self.Target.CFrame
		end
	end)
end

return CameraController