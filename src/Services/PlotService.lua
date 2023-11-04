local ReplicatedStorage = game.ReplicatedStorage
local Packages = ReplicatedStorage.Packages

local Knit = require(Packages.Knit)

local PlotService = Knit.CreateService {
Name = "PlotService",
Client = {
createNewPlot = Knit.CreateSignal(),
}
}

PlotService.Plots = {}

function createPlot(player)
    PlotService.Plots[player.Name] = {
        ["Name"] = player.Name .. "'s Web Cafe",
        ["Cash"] = 1000,
        ["Building"] = "Default_1",
    }
    print("Successfully created plot for " .. player.Name)
    print(PlotService.Plots[player.Name])
end

function PlotService:KnitInit()
    self.Client.createNewPlot:Connect(function(player)
        createPlot(player)
    end)
end

function PlotService:KnitStart()
    print("Successfully started PlotService")
end

return PlotService