-- Assuming QBCore is already initialized
local QBCore = exports['qb-core']:GetCoreObject()

-- Function to deduct a percentage of paycheck based on job type
function DeductPercentageFromPaycheck(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local job = xPlayer.PlayerData.job
        local paycheck = xPlayer.PlayerData.money['bank']
        local deductionPercentage = GetDeductionPercentage(job)
        local deductionAmount = paycheck * (deductionPercentage / 100)

        -- Deduct the amount from player's paycheck
        xPlayer.Functions.RemoveMoney('bank', deductionAmount)

        -- Add the deducted amount to government account
        -- Assuming there's a function to add money to government account
        AddMoneyToGovernmentAccount(deductionAmount)

        print("[INFO] Deducted "..deductionAmount.." from "..xPlayer.PlayerData.name.."'s paycheck.")
    else
        print("[ERROR] Player not found.")
    end
end

-- Function to get deduction percentage based on job type
function GetDeductionPercentage(job)
    local percentage = 0

    -- Fetch the deduction percentage from the database
    MySQL.Async.fetchScalar('SELECT deductionPercentage FROM jobPercentages WHERE jobType = @jobType', {
        ['@jobType'] = job
    }, function(deductionPercentage)
        if deductionPercentage then
            percentage = deductionPercentage
        else
            print("[ERROR] Deduction percentage not found for job type: "..job)
        end
    end)

    return percentage
end

-- Function to add money to government account
function AddMoneyToGovernmentAccount(amount)
    -- Add your logic here to add money to government account
    -- This might involve calling a function from qb-management
    print("[INFO] Added "..amount.." to government account.")
end

-- Register the event that triggers every time a player receives their paycheck
RegisterNetEvent('qb-paycheck:server:givePaycheck', function()
    local source = source
    DeductPercentageFromPaycheck(source)
end)