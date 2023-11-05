--// Configurables

local autoSave = true
local autoLoad = true

--// Services and Locations

local ReplicatedStorage = game.ReplicatedStorage
local ServerScriptService = game.ServerScriptService
local Players = game.Players 

local Packages = ReplicatedStorage.Packages
local Knit = require(Packages.Knit)

local UserDataService = Knit.CreateService {Name = "UserDataService",Client = {}}
local ProfileService = require(ServerScriptService.ProfileService)

--// Data Management

UserDataService.Profiles = {}

local dataTemplate = {
    Saves = {},
    Gems = 0,
}

local ProfileStore = ProfileService.GetProfileStore(
    "PlayerProfile",
    dataTemplate
)

--// Functions

local function LoadData(player)
    local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
    if profile then
        profile:AddUserId(player.UserId)
        profile:Reconcile()

        profile:ListenToRelease(function()
            UserDataService.Profiles[player] = nil
            player:Kick()
        end)

        if not player:IsDescendantOf(Players) then
            profile:Release()
        else
            UserDataService.Profiles[player] = profile
            return UserDataService.Profiles[player]
        end
    else
        player:Kick("Unexpected error")
    end
end

local function SaveData(player)
    
end

Players.PlayerAdded:Connect(function(Player)
    if autoLoad == false then return end
    local playerData = LoadData(Player)
    warn(playerData)
end)

Players.PlayerRemoving:Connect(function()
    if autoSave == false then return end
    print(SaveData(player))
end)





return UserDataService