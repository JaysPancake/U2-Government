local QBCore = exports['qb-core']:GetCoreObject() -- Import QB Core

RegisterServerEvent('taxes:pay')
AddEventHandler('taxes:pay', function()
    local playerId = source
    local u2Player = QBCore.Functions.GetPlayerData()
    local salary = u2Player.job.payment
    local jobName = u2Player.job.name
    
    -- retrieve the tax percentage from the job table in the database
    local taxPercent = 0.1 -- default value
    QBCore.Functions.ExecuteSql('SELECT tax_percent FROM job_tax WHERE job_name = ?', {jobName}, function(result)
        if result[1] ~= nil and result[1].tax_percent ~= nil then
            taxPercent = result[1].tax_percent
        end
    end)
    
    local amountToRemove = math.floor(salary * taxPercent)
    
    u2Player.removeBankMoney(amountToRemove, "Paid salary") -- use the qb-core function to remove money from player's bank account
    
    -- add the deducted amount to the society fund called "government"
    local society = exports['qb-management']:GetAccount(Player.PlayerData.job.name)
    society.addMoney(amountToRemove)
    
    TriggerClientEvent('QBCore:Notify', playerId, "You received your paycheck, $" .. salary - amountToRemove .. " was deposited into your bank account. $" .. amountToRemove .. " was paid in taxes.") -- notify the player about their paycheck and the taxes paid
end)

RegisterCommand("paytaxes", function(source, args)
    TriggerEvent("taxes:pay")
    TriggerClientEvent('chat:addMessage', source, { args = {"^1[Tax System]", "^2Taxes have been paid."} })
end, false)

RegisterCommand('testgetgangaccount', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local gang = Player.PlayerData.gang.name
    local society = exports['qb-management']:GetGangAccount(gang)
    print(society) -- if society exists prints balance else prints 0
end)