local ReplicatedStorage = game.ReplicatedStorage
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages:WaitForChild("Knit"))

local PlotController = Knit.CreateController {Name = "PlotController"}


-- // Variables

local PlotService
local Player
local PlayerGui
local MainGUI
local MenuGUI

function PlotController:KnitInit()
	-- Knit init
end

function PlotController:KnitStart()
	PlotService = Knit.GetService("PlotService")
	Player = game.Players.LocalPlayer
	PlayerGui = Player.PlayerGui
	MainGUI = PlayerGui:WaitForChild("UI")
	MenuGUI = MainGUI:WaitForChild("Menu")
	print("PlotController has been started")

	MenuGUI:WaitForChild("PlayButton").MouseButton1Up:Connect(function()
		local createNewPlot = PlotService.createNewPlot:Fire()
	end)
end

return PlotController