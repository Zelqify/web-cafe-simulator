local ReplicatedStorage = game.ReplicatedStorage
local RunService = game:GetService("RunService")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages:WaitForChild("Knit"))

local PlotController = Knit.CreateController {Name = "PlotController"}


-- // Variables

local PlotService
local CameraController
local Player
local PlayerGui
local MainGUI
local MenuGUI
local PlotSelectorGUI

local isSelectingPlot = false
local SelectedPlot = 1
local AvailablePlots = {}

function PlotController:KnitInit()
	-- Knit init
end

function PlotController:KnitStart()
	PlotService = Knit.GetService("PlotService")
	Player = game.Players.LocalPlayer
	PlayerGui = Player.PlayerGui
	MainGUI = PlayerGui:WaitForChild("UI")
	MenuGUI = MainGUI:WaitForChild("Menu")
	PlotSelectorGUI = MainGUI:WaitForChild("PlotSelector")
	print("PlotController has been started")

	MenuGUI:WaitForChild("PlayButton").MouseButton1Up:Connect(function()
		--local createNewPlot = PlotService.createNewPlot:Fire()
		CameraController = Knit.GetController("CameraController")
		isSelectingPlot = true
	--	local VisualEffectsController = Knit.GetController("VisualEffectsController")
	--CameraController.isOnTarget = false
		MenuGUI.Visible = false
		PlotSelectorGUI.Visible = true

	-- VisualEffectsController:PlayLoadEffect(1.5)
	end)
	PlotSelectorGUI:WaitForChild("Left").MouseButton1Up:Connect(function()
		if SelectedPlot == 1 then
		 SelectedPlot = #AvailablePlots
		else
			SelectedPlot -= 1
		end
	end)
	
	PlotSelectorGUI:WaitForChild("Right").MouseButton1Up:Connect(function()
		if SelectedPlot == #AvailablePlots then
		 SelectedPlot = 1
		else
			SelectedPlot += 1
		end
	end)
	
end


RunService.RenderStepped:Connect(function()
	if isSelectingPlot then
		AvailablePlots = {}
		for _,v in pairs(game.Workspace.Plots:GetChildren()) do 
			if v.Name == "PLOT" then
				table.insert(AvailablePlots, v)
			end
		end
		CameraController.Target = AvailablePlots[SelectedPlot]:WaitForChild("Settings").Camera.Value
	end
end)



return PlotController