QBCore = exports['qb-core']:GetCoreObject() -- Used Globally

local AlarmActivated = false

RegisterServerEvent('prison:server:SetJailStatus')
AddEventHandler('prison:server:SetJailStatus', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("injail", jailTime)
end)

RegisterServerEvent('prison:server:SaveJailItems')
AddEventHandler('prison:server:SaveJailItems', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = 10
    if Player.PlayerData.metadata["jailitems"] == nil or next(Player.PlayerData.metadata["jailitems"]) == nil then 
        Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
        Player.Functions.AddMoney('cash', 80)
        Citizen.Wait(2000)
        Player.Functions.ClearInventory()
    else
        Player.Functions.ClearInventory()
    end
end)

RegisterServerEvent('electricity:reward')
AddEventHandler('electricity:reward', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local reward = math.random(25, 50)
	
	Player.Functions.AddMoney('cash', reward)
end)

RegisterServerEvent('prison:server:GiveJailItems')
AddEventHandler('prison:server:GiveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    for k, v in pairs(Player.PlayerData.metadata["jailitems"]) do
        Player.Functions.AddItem(v.name, v.amount, false, v.info)
    end

    Citizen.Wait(1000)
    Player.Functions.SetMetaData("jailitems", {})
end)

RegisterServerEvent('prison:server:SecurityLockdown')
AddEventHandler('prison:server:SecurityLockdown', function()
    local src = source
    TriggerClientEvent("prison:client:SetLockDown", -1, true)
    --TriggerClientEvent("dispatch:prisonBreak", src)
end)


RegisterServerEvent('prison:server:CheckRecordStatus')
AddEventHandler('prison:server:CheckRecordStatus', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CriminalRecord = Player.PlayerData.metadata["criminalrecord"]
    local currentDate = os.date("*t")

    if (CriminalRecord["date"].month + 1) == 13 then
        CriminalRecord["date"].month = 0
    end

    if CriminalRecord["hasRecord"] then
        if currentDate.month == (CriminalRecord["date"].month + 1) or currentDate.day == (CriminalRecord["date"].day - 1) then
            CriminalRecord["hasRecord"] = false
            CriminalRecord["date"] = nil
        end
    end
end)

RegisterServerEvent('prison:server:JailAlarm')
AddEventHandler('prison:server:JailAlarm', function()
    if not AlarmActivated then
        TriggerClientEvent('prison:client:JailAlarm', -1, true)
        SetTimeout(5 * (60 * 1000), function()
            TriggerClientEvent('prison:client:JailAlarm', -1, false)
        end)
    end
end)

QBCore.Functions.CreateUseableItem("electronickit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("electronickit:UseElectronickit", source)
    end
end)

QBCore.Functions.CreateCallback('prison:server:IsAlarmActive', function(source, cb)
    cb(AlarmActivated)
end)

-- function BuildPoly()
--     for name, value in next, Config.Zones do
--         if value['points'] then
--             exports['qb-polyzone']:Polyzone(name, value['points'], value['options'], true)
--         end
--     end
-- end

-- CreateThread(BuildPoly)
-- RegisterNetEvent("qb-polyzone:ready", BuildPoly)