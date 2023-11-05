--// Configurables

local autoSave = true
local autoLoad = true

--// Services and Locations

local ReplicatedStorage = game.ReplicatedStorage
local ServerScriptService = game.ServerScriptService
local Players = game.Players 

local Packages = ReplicatedStorage.Packages
local Knit = require(Packages.Knit)

local UserDataService = Knit.CreateService {Name = "UserDataService",Client = {
    getData = Knit.CreateSignal(),
    registerPlot = Knit.CreateSignal(),
}}
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
    if UserDataService.Profiles[player] then
        UserDataService.Profiles[player]:Release()
    end
end

Players.PlayerAdded:Connect(function(Player)
    if autoLoad == false then return end
    local playerData = LoadData(Player)
    warn(playerData)
end)

Players.PlayerRemoving:Connect(function(player)
    if autoSave == false then return end
    SaveData(player)
end)

local function getProfile(Player)
    assert(UserDataService.Profiles[Player], string.format("Profile does not exist for %s", Player.UserId))
    return UserDataService.Profiles[Player]
end

function UserDataService:Get(player, key)
    local profile = getProfile(player)
    return profile.Data["Saves"][PlotKey]
end

function UserDataService:Set(player, PlotKey, value)
    local profile = getProfile(player)
    profile.Data["Saves"][PlotKey] = value
end

function UserDataService:Update(player, key, callback)
    local profile = getProfile(player)
    local oldData = self:Get(player, key)
    local newData = callback(oldData)
    self:Set(player, key, newData)
end

function UserDataService:KnitStart()
    print("UserDataService has been started")
    UserDataService.Client.getData:Connect(function(player)
        print("Contacted!")
        UserDataService.Client.getData:Fire(player, getProfile(player).Data)
    end)
    UserDataService.Client.registerPlot:Connect(function(player)
        print("Registering plot!")
        local profile = getProfile(player)
        local PlotKey = tostring(#profile.Data.Saves + 1)
        self:Set(player, PlotKey, {"Test plotValue!"})
        print(getProfile(player))
    end)
    
end

return UserDataService