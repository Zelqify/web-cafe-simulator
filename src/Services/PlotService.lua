local ReplicatedStorage = game.ReplicatedStorage
local Packages = ReplicatedStorage.Packages

local Knit = require(Packages.Knit)

local PlotService = Knit.CreateService {
Name = "PlotService",
Client = {
createNewPlot = Knit.CreateSignal(),
loadUserSaves = Knit.CreateSignal(),
}
}

PlotService.Plots = {}

function createPlot(player)
    PlotService.Plots[player.Name] = {
        ["Name"] = player.Name .. "'s Web Cafe",
        ["Cash"] = 1000,
        ["Building"] = "Default_1",
        ["PlotLocation"] = game.Workspace.Plots:FindFirstChild("PLOT")
    }
    PlotService.Plots[player.Name].PlotLocation.Name = player.Name
    print("Successfully created plot for " .. player.Name)
    print(PlotService.Plots[player.Name])
end

function PlotService:KnitInit()
    self.Client.createNewPlot:Connect(function(player)
        createPlot(player)
    end)
    self.Client.loadUserSaves:Connect(function(player)
        return 
    end)

end

function PlotService:KnitStart()
    print("Successfully started PlotService")
end

return PlotService