local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-laptop:server:crateOpened', function(crateID)
    local _s = source
    QBCore.Functions.GetPlayer(_s).Functions.RemoveItem('drill', 1)
    crates[crateID].isOpened = true
    TriggerClientEvent('qb-laptop:client:updateCrates', -1, crates)
end)

QBCore.Functions.CreateCallback('qb-laptop:server:getCrateStatus', function(source, cb, crateNetID, crateentity)
    crates[crateNetID].isOpened = false

    local data = {
        isOpened = crates[crateNetID].isOpened,
        crateID = crates[crateNetID].id,
        crate = crateentity
    }
    cb(data)
end)

QBCore.Functions.CreateCallback('qb-laptop:server:getAllCrates', function(source, cb)
    cb(crates)
end)