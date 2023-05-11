local QBCore = exports['qb-core']:GetCoreObject() -- Import QB-Core
local Player = QBCore.Functions.GetPlayerData() -- Get QB Player Data
local jobName = Player.job.name -- Get QB Player Job
print(jobName)