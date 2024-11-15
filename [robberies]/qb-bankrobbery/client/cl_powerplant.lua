local QBCore = exports['qb-core']:GetCoreObject()

local closestStation = 0
local currentStation = 0

-- START UP EVENTS
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-powerplant:server:GetConfig', function(config)
        Config = config
    end)
end)

RegisterNetEvent('restorepower', function()
    TriggerServerEvent('power')
    end)


CreateThread(function()
    for k, v in pairs(Config.PowerStations) do
        if k == 1 or k == 2 then
            exports['qb-target']:AddBoxZone("PowerPlantStation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.5, 0.65, {
                name = "PowerPlantStation"..k,
                heading = 162,
                debugPoly = false,
                minZ = 24.65,
                maxZ = 25.35,
                }, {
                    options = { 
                    {
                        type = "client",
                        event = "qb-powerplant:client:thermite",
                        icon = 'fas fa-user-secret',
                        label = 'Blow Fuses',
                        canInteract = function()
                            if Config.PowerStations[k].hit then
                                return false
                            end
                            return true
                        end,
                    },
                    {
                        type = "client",
                        event = "restorepower",
                        icon = 'fas fa-user-secret',
                        label = 'Restore Power',
                        job = 'police',
                        canInteract = function()
                            if not Config.PowerStations[k].hit then
                                return false
                            end
                            return true
                        end,
                    }
                },
                distance = 1.0,
            })
        elseif k == 3 or k == 4 then
            exports['qb-target']:AddBoxZone("PowerPlantStation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.5, 1.6, {
                name = "PowerPlantStation"..k,
                heading = 255,
                debugPoly = false,
                minZ = 44.80,
                maxZ = 45.80,
                }, {
                    options = { 
                    {
                        type = "client",
                        event = "qb-powerplant:client:thermite",
                        icon = 'fas fa-user-secret',
                        label = 'Destroy Generator',
                        canInteract = function()
                            if Config.PowerStations[k].hit then
                                return false
                            end
                            return true
                        end,
                    },
                    
                },
                distance = 1.50,
            })
        else
            exports['qb-target']:AddBoxZone("PowerPlantStation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.5, 0.6, {
                name = "PowerPlantStation"..k,
                heading = 160,
                debugPoly = false,
                minZ = 80.90,
                maxZ = 81.50,
                }, {
                    options = { 
                    {
                        type = "client",
                        event = "qb-powerplant:client:thermite",
                        icon = 'fas fa-user-secret',
                        label = 'Blow Fuses',
                        canInteract = function()
                            if Config.PowerStations[k].hit then
                                return false
                            end
                            return true
                        end,
                    },
                    {
                        type = "client",
                        event = "restorepower",
                        icon = 'fas fa-user-secret',
                        label = 'Restore Power',
                        job = 'police',
                        canInteract = function()
                            if not Config.PowerStations[k].hit then
                                return false
                            end
                            return true
                        end,
                    }
                },
                distance = 1.0,
            })
        end
    end
end)

local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

local function ThermiteEffect()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Wait(50)
    end
    local ped = PlayerPedId()
    local ptfx = vector3(Config.PowerStations[closestStation].ptfx.x, Config.PowerStations[closestStation].ptfx.y, Config.PowerStations[closestStation].ptfx.z)
    Wait(1500)
    TriggerServerEvent("qb-powerplant:server:ThermitePtfx", ptfx)
    Wait(500)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(20000)
    ClearPedTasks(ped)
    Wait(2000)
end

local function ppExplosion(x,y,z)
    CreateThread(function()
        SetPtfxAssetNextCall("core")
        local smoke = StartParticleFxLoopedAtCoord("exp_air_blimp", x, y, z, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
        SetParticleFxLoopedAlpha(smoke, 0.8)
        SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
        AddExplosion(x, y, z, EXPLOSION_BLIMP, 0.0, true, false, 3.0)
    end)
end

local function ThermitePowerPlantCharge()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    local ped = PlayerPedId()
    local pos = vector3(Config.PowerStations[closestStation].animation.x, Config.PowerStations[closestStation].animation.y, Config.PowerStations[closestStation].animation.z)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(charge)
    end)
end

local function ThermitePowerPlantSuccess()
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermitecharge", 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermitecharge"], "remove")
    ThermiteEffect()
    TriggerServerEvent("blow:test")
end

local function ThermitePowerPlantFailed()
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermitecharge", 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermitecharge"], "remove")
    QBCore.Functions.Notify("Thermite failed..", "error")
end

RegisterNetEvent('qb-powerplant:client:thermite', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if closestStation ~= 0 then
        if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
        local dist = #(pos - vector3(Config.PowerStations[closestStation].coords.x, Config.PowerStations[closestStation].coords.y, Config.PowerStations[closestStation].coords.z))
        if dist < 1.20 then
            QBCore.Functions.TriggerCallback('qb-powerplant:server:getCops', function(cops)
                if cops >= Config.MinimumThermitePolice then
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasitem)
                        if hasitem then
                    if not Config.PowerStations[closestStation].hit then
                        currentStation = closestStation
                        TriggerServerEvent("qb-log:server:CreateLog", "powerplants", "Thermite", "white", "**"..GetPlayerName(PlayerId()).."** used thermite on station: "..closestStation)
                        -- charge animation
                        ThermitePowerPlantCharge()
                        exports["memorygame"]:thermiteminigame(8, 3, 3, 8,
                        function() -- success
                            TriggerEvent('qb-dispatch:powerStation')
                            ThermitePowerPlantSuccess()
                        end,
                        function() -- failure
                            ThermitePowerPlantFailed()
                        end)
                    else
                        QBCore.Functions.Notify("It looks like the fuses have blown..", "error")
                    end
                else
                    QBCore.Functions.Notify('Missing Thermite Charge', 'error')
                end
            end, 'thermitecharge')
            else
                QBCore.Functions.Notify('Not Enough Police ('.. Config.MinimumThermitePolice ..') Required', 'error')
            end
        end)
    end
    end
end)

RegisterNetEvent('thermite:UseThermite', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if closestStation ~= 0 then
        if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
        local dist = #(pos - vector3(Config.PowerStations[closestStation].coords.x, Config.PowerStations[closestStation].coords.y, Config.PowerStations[closestStation].coords.z))
        if dist < 1 then
            QBCore.Functions.TriggerCallback('qb-powerplant:server:getCops', function(cops)
                if cops >= Config.MinimumThermitePolice then
                    if not Config.PowerStations[closestStation].hit then
                        currentStation = closestStation
                        TriggerServerEvent("qb-log:server:CreateLog", "powerplants", "Thermite", "white", "**"..GetPlayerName(PlayerId()).."** used thermite on station: "..closestStation)
                        -- charge animation
                        ThermitePowerPlantCharge()
                        exports["memorygame"]:thermiteminigame(8, 3, 3, 8,
                        function() -- success
                            ThermitePowerPlantSuccess()
                        end,
                        function() -- failure
                            ThermitePowerPlantFailed()
                        end)
                    else
                        QBCore.Functions.Notify("It looks like the fuses have blown..", "error")
                    end
                else
                    QBCore.Functions.Notify('Not Enough Police ('.. Config.MinimumThermitePolice ..') Required', 'error')
                end
            end)
        end
    end
end)

RegisterNetEvent("qb-powerplant:client:ThermitePtfx", function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(27500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-powerplant:client:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
end)

RegisterNetEvent('qb-powerplant:powerplant:client:city:boom', function()
    ppExplosion(710.22,125.44,84.90)
    Wait(350)
    ppExplosion(707.13, 106.91, 84.479)
    Wait(350)
    ppExplosion(698.28, 101.89, 84.47)
    Wait(350)
    ppExplosion(664.408,114.9,84.47)
    Wait(350)
    ppExplosion(664.00, 133.15, 84.01)
    Wait(350)
    ppExplosion(673.67, 157.436, 85.47)
    Wait(350)
    ppExplosion(673.67, 157.436, 84.47)
end)

RegisterNetEvent('qb-powerplant:powerplant:client:east:boom', function()
    ppExplosion(2727.0825, 1477.4373, 35.695354)
    Wait(350)
    ppExplosion(2742.2595, 1507.0069, 35.695354)
    Wait(350)
    ppExplosion(2737.3876, 1536.5502, 35.6748)
    Wait(350)
    ppExplosion(2755.0556, 1571.2738, 39.294418)
    Wait(350)
    ppExplosion(2815.0053, 1512.393, 29.195352)
    Wait(350)
    ppExplosion(2830.6501, 1490.4455, 29.195352)
    Wait(350)
    ppExplosion(2839.4997, 1562.3775, 29.195352)
end)

CreateThread(function()
    while true do
        Wait(3)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        
        for k, v in pairs(Config.PowerStations) do
            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist < 5 then
                closestStation = k
                inRange = true
            end
        end

        if not inRange then
            Wait(1000)
            closestStation = 0
        end
    end
end)