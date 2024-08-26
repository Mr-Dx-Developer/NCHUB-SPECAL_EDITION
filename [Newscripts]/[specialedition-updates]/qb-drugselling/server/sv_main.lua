local QBCore = exports['qb-core']:GetCoreObject()

local function getAvailableDrugs(source)
    local AvailableDrugs = {}
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return nil end

    for drug, prices in pairs(Config.Drugs) do
        local item = Player.Functions.GetItemByName(drug)

        if item then
            AvailableDrugs[#AvailableDrugs + 1] = {
                item = item.name,
                amount = item.amount,
                label = QBCore.Shared.Items[item.name]["label"],
                minPrice = prices.min,
                maxPrice = prices.max,
                percentPolice = prices.percent_police
            }
        end
    end
    return next(AvailableDrugs) ~= nil and AvailableDrugs or nil
end

QBCore.Functions.CreateCallback('apple:start:sell:getAvailableDrugs', function(source, cb)
    cb(getAvailableDrugs(source))
end)

RegisterNetEvent('qb-drugselling:server:sellCornerDrugs', function(drugType, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local availableDrugs = getAvailableDrugs(src)
    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item

    local hasItem = Player.Functions.GetItemByName(item)
    if hasItem.amount >= amount then
        TriggerClientEvent('QBCore:Notify', src, "Success", 'success')
        Player.Functions.RemoveItem(item, amount)
        Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
        TriggerClientEvent('qb-drugselling:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
    else
        print("Drug Aval :",availableDrugs)
    end
end)

local function GetCurrentCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" then
            amount = amount + 1
        end
    end
    return amount
end

-- Threads
CreateThread(function()
    while true do
        local curCops = GetCurrentCops()
        TriggerClientEvent("qb-drugselling:police:copCount", -1, curCops)
        Wait(5000)
    end
end)