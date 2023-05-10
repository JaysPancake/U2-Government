local QBCore = exports['qb-core']:GetCoreObject() -- Import QB-Core
local Player = QBCore.Functions.GetPlayerData() -- Get QB Player Data
print(QBCore.Debug(Player))
local jobName = Player.job.name
print(jobName)