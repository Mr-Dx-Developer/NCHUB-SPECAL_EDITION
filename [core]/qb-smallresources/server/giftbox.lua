local QBCore = exports['qb-core']:GetCoreObject()

--ADD IN SERVER SIDE IF USING AS SNIPPET

QBCore.Functions.CreateUseableItem("gift_box",function(source, item)
    TriggerClientEvent("consumables:client:openGiftbox", source, item.name)
end)

RegisterNetEvent('consumables:server:giftFinished', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('gift_box', 1) then
        TriggerClientEvent("inventory:client:ItemBox",source, QBCore.Shared.Items['gift_box'], "remove")
        for name, amt in pairs(Config.GiftItems) do
            Player.Functions.AddItem(name, amt)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[name], "add")
        end
    end
end)