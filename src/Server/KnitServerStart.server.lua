local ReplicatedStorage = game.ReplicatedStorage
local ServerStorage = game.ServerStorage

local Packages = ReplicatedStorage.Packages

local Knit = require(Packages.Knit)

Knit.AddServices(ServerStorage.Services)

Knit.Start():andThen(function()
    print("Knit Started Server.")
end):catch(warn)