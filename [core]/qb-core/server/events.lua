-- Event Handler

AddEventHandler('playerDropped', function()
    local src = source
    local ped = GetPlayerPed(src)
    local armor = GetPedArmour(ped)
    local health = GetEntityHealth(ped)

    if not QBCore.Players[src] then return end
    local Player = QBCore.Players[src]
    TriggerEvent('qb-logs:server:CreateLog', 'joinleave', 'Dropped', 'red', '**' .. GetPlayerName(src) .. '** (' .. Player.PlayerData.license .. ') left..')
    Player.Functions.SetMetaData('health', health)
    Player.Functions.SetMetaData('armor', armor)
    Player.Functions.Save()
    QBCore.Player_Buckets[Player.PlayerData.license] = nil
    QBCore.Players[src] = nil
end)

AddEventHandler('chatMessage', function(source, n, message)
    local src = source
    if string.sub(message, 1, 1) == '/' then
        local args = QBCore.Shared.SplitStr(message, ' ')
        local command = string.gsub(args[1]:lower(), '/', '')
        CancelEvent()
        if QBCore.Commands.List[command] then
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                local isGod = QBCore.Functions.HasPermission(src, 'god')
                local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
                local isPrincipal = IsPlayerAceAllowed(src, 'command')
                table.remove(args, 1)
                if isGod or hasPerm or isPrincipal then
                    if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
                        TriggerClientEvent('QBCore:Notify', src, 'All arguments must be filled out!', 'error')
                    else
                        QBCore.Commands.List[command].callback(src, args)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, 'No Access To This Command', 'error')
                end
            end
        end
    end
end)

-- 
-- Single Remove Item
local function RemoveItem(itemName)
    if type(itemName) ~= "string" then
        return false, "invalid_item_name"
    end

    if not QBCore.Shared.Items[itemName] then
        return false, "item_not_exists"
    end

    QBCore.Shared.Items[itemName] = nil

    TriggerClientEvent('QBCore:Client:OnSharedUpdate', -1, 'Items', itemName, nil)
    TriggerEvent('QBCore:Server:UpdateObject')
    return true, "success"
end

QBCore.Functions.RemoveItem = RemoveItem
exports('RemoveItem', RemoveItem)


-- Player Connecting

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local license
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()

    -- mandatory wait!
    Wait(0)

    deferrals.update(string.format('Hello %s. Validating Your Rockstar License', name))

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    -- mandatory wait!
    Wait(2500)

    deferrals.update(string.format('Hello %s. We are checking if you are banned.', name))

    local isBanned, Reason = QBCore.Functions.IsPlayerBanned(player)
    local isLicenseAlreadyInUse = QBCore.Functions.IsLicenseInUse(license)

    Wait(2500)

    deferrals.update(string.format('Welcome %s to {Server Name}.', name))

    if not license then
        deferrals.done('No Valid Rockstar License Found')
    elseif isBanned then
        deferrals.done(Reason)
    elseif isLicenseAlreadyInUse then
        deferrals.done('Duplicate Rockstar License Found')
    else
        deferrals.done()
        Wait(1000)
        TriggerEvent('connectqueue:playerConnect', name, setKickReason, deferrals)
    end
    --Add any additional defferals you may need!
end

AddEventHandler('playerConnecting', OnPlayerConnecting)

-- Open & Close Server (prevents players from joining)

RegisterNetEvent('QBCore:server:CloseServer', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god') then
        local reason = reason or 'No reason specified'
        QBCore.Config.Server.closed = true
        QBCore.Config.Server.closedReason = reason
        TriggerClientEvent('qbadmin:client:SetServerStatus', -1, true)
    else
        QBCore.Functions.Kick(src, 'You don\'t have permissions for this..', nil, nil)
    end
end)

RegisterNetEvent('QBCore:server:OpenServer', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god') then
        QBCore.Config.Server.closed = false
        TriggerClientEvent('qbadmin:client:SetServerStatus', -1, false)
    else
        QBCore.Functions.Kick(src, 'You don\'t have permissions for this..', nil, nil)
    end
end)

-- Play Time
RegisterNetEvent('QBCore:UpdatePlayer', function(PlayerData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local newHunger = Player.PlayerData.metadata['hunger'] - QBCore.Config.Player.HungerRate
        local newThirst = Player.PlayerData.metadata['thirst'] - QBCore.Config.Player.ThirstRate
        local playtimes = Player.PlayerData.metadata['playtime']
        local playtimen = tonumber(playtimes) -- 5=5 minutes
        Player.PlayerData.metadata['playtime'] = playtimen + 5
        if newHunger <= 0 then
            newHunger = 0
        end
        if newThirst <= 0 then
            newThirst = 0
        end
        Player.Functions.SetMetaData('thirst', newThirst)
        Player.Functions.SetMetaData('hunger', newHunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
        Player.Functions.Save()
    end
end)

-- Callbacks

RegisterNetEvent('QBCore:Server:TriggerCallback', function(name, ...)
    local src = source
    QBCore.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('QBCore:Client:TriggerCallback', src, name, ...)
    end, ...)
end)

-- Player

RegisterNetEvent('QBCore:UpdatePlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local newHunger = Player.PlayerData.metadata['hunger'] - QBCore.Config.Player.HungerRate
        local newThirst = Player.PlayerData.metadata['thirst'] - QBCore.Config.Player.ThirstRate
        if newHunger <= 0 then
            newHunger = 0
        end
        if newThirst <= 0 then
            newThirst = 0
        end
        Player.Functions.SetMetaData('thirst', newThirst)
        Player.Functions.SetMetaData('hunger', newHunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
        Player.Functions.Save()
    end
end)

RegisterNetEvent('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if meta == 'hunger' or meta == 'thirst' then
        if data > 100 then
            data = 100
        end
    end
    if Player then
        Player.Functions.SetMetaData(meta, data)
    end
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'])
end)

RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('QBCore:Notify', src, 'You are now off duty!')
    else
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('QBCore:Notify', src, 'You are now on duty!')
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
end)

-- Items

RegisterNetEvent('QBCore:Server:UseItem', function(item)
    local src = source
    if item and item.amount > 0 then
        if QBCore.Functions.CanUseItem(item.name) then
            QBCore.Functions.UseItem(src, item)
        end
    end
end)

RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(itemName, amount, slot)
end)

-- This event is exploitable and should not be used. It has been deprecated, and will be removed soon. function(itemName, amount, slot, info)
RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount)
    local src = source
    print(string.format("%s triggered QBCore:Server:AddItem by ID %s for %s %s. This event is deprecated due to exploitation, and will be removed soon. Adjust your events accordingly to do this server side with player functions.", GetInvokingResource(), src, amount, itemName))
end)
-- Non-Chat Command Calling (ex: qb-adminmenu)

RegisterNetEvent('QBCore:CallCommand', function(command, args)
    local src = source
    if QBCore.Commands.List[command] then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            local isGod = QBCore.Functions.HasPermission(src, 'god')
            local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
            local isPrincipal = IsPlayerAceAllowed(src, 'command')
            if (QBCore.Commands.List[command].permission == Player.PlayerData.job.name) or isGod or hasPerm or isPrincipal then
                if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
                    TriggerClientEvent('QBCore:Notify', src, 'All arguments must be filled out!', 'error')
                else
                    QBCore.Commands.List[command].callback(src, args)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'No Access To This Command', 'error')
            end
        end
    end
end)

-- Has Item Callback (can also use client function - QBCore.Functions.HasItem(item))

-- QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, items, amount)
--     local src = source
--     local retval = false
--     local Player = QBCore.Functions.GetPlayer(src)
--     if Player then
--         if type(items) == 'table' then
--             local count = 0
--             local finalcount = 0
--             for k, v in pairs(items) do
--                 if type(k) == 'string' then
--                     finalcount = 0
--                     for i, _ in pairs(items) do
--                         if i then
--                             finalcount = finalcount + 1
--                         end
--                     end
--                     local item = Player.Functions.GetItemByName(k)
--                     if item then
--                         if item.amount >= v then
--                             count = count + 1
--                             if count == finalcount then
--                                 retval = true
--                             end
--                         end
--                     end
--                 else
--                     finalcount = #items
--                     local item = Player.Functions.GetItemByName(v)
--                     if item then
--                         if amount then
--                             if item.amount >= amount then
--                                 count = count + 1
--                                 if count == finalcount then
--                                     retval = true
--                                 end
--                             end
--                         else
--                             count = count + 1
--                             if count == finalcount then
--                                 retval = true
--                             end
--                         end
--                     end
--                 end
--             end
--         else
--             local item = Player.Functions.GetItemByName(items)
--             if item then
--                 if amount then
--                     if item.amount >= amount then
--                         retval = true
--                     end
--                 else
--                     retval = true
--                 end
--             end
--         end
--     end
--     cb(retval)
-- end)