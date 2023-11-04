

local ReplicatedStorage = game.ReplicatedStorage
local ServerStorage = game.ServerStorage

local Packages = ReplicatedStorage.Packages

local Knit = require(Packages:WaitForChild("Knit"))

Knit.AddControllers(ReplicatedStorage:WaitForChild("Controllers"))

Knit.Start():andThen(function()
    print("Knit Started Client.")
end):catch(warn)