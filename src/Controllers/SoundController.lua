local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages:WaitForChild("Knit"))

local SoundController = Knit.CreateController {Name = "SoundController"}

-- // Variables

local Player
-- // Sound List

SoundController.ClickSound = game.ReplicatedStorage.Sounds.Click

function SoundController:KnitInit()
	-- Knit init
end

function SoundController:KnitStart()
	local SoundStorage = Instance.new("Folder")
	SoundStorage.Parent = ReplicatedStorage
	SoundStorage.Name = "SoundStorage"
	Player = game.Players.LocalPlayer
	print("SoundController has been started")
	UserInputService.InputBegan:Connect(function(input, gameProc)
		if gameProc and input.UserInputType == Enum.UserInputType.MouseButton1 then
			SoundController.ClickSound:Play()
		end
	end)
end


return SoundController
