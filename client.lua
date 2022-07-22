local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('mr-toolbox:client:SpawnarMesa', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)
    local model = Config.Object,
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    QBCore.Functions.Progressbar('name_here', 'PLACING ToolBox...', 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@medic@standing@tendtodead@base',
        anim = 'base',
        flags = 16,
    }, {}, {}, function()
        local obj = CreateObject(model, x, y, z, true, false, true)
        PlaceObjectOnGroundProperly(obj)
        SetEntityAsMissionEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', Config.SpawnItem, 1)
        TriggerEvent(Config.InventoryTrigger, QBCore.Shared.Items[Config.SpawnItem], "remove")
    end)
end)

RegisterNetEvent('mr-toolbox:client:repairkit1', function()
    QBCore.Functions.Progressbar('name_here', 'Upgrade Axe...', 900, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('mr-toolbox:server:repairkit')
    end)
end)

RegisterNetEvent('mr-toolbox:client:cleaningkit', function()
    QBCore.Functions.Progressbar('name_here', 'Upgrade Axe...', 900, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('mr-toolbox:server:cleaning')
    end)
end)

RegisterNetEvent('mr-toolbox:client:lockpickkit', function()
    QBCore.Functions.Progressbar('name_here', 'Upgrade Axe...', 900, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('mr-toolbox:server:lockpick')
    end)
end)

RegisterNetEvent('mr-toolbox:client:EliminarMesa', function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = QBCore.Functions.GetClosestObject(coords)
    if DoesEntityExist(obj) then
        QBCore.Functions.Progressbar('name_here', 'TAKING ToolBox...', 500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'amb@medic@standing@tendtodead@base',
            anim = 'base',
            flags = 16,
        }, {}, {}, function()
            DeleteEntity(obj)
            TriggerServerEvent('QBCore:Server:AddItem', Config.SpawnItem, 1)
            TriggerEvent(Config.InventoryTrigger, QBCore.Shared.Items[Config.SpawnItem], "AddItem")
        end)
    end
end)

RegisterNetEvent("mr-toolbox:toolbox")
AddEventHandler("mr-toolbox:toolbox", function()
    TriggerEvent(Config.StashInvTrigger, "ToolBox")
    TriggerServerEvent(Config.OpenInvTrigger, "stash", "ToolBox", {
        maxweight = 50000,
        slots = 20,
    })
end)

RegisterNetEvent('mr-toolbox:client:toolbox', function()
    exports['qb-menu']:openMenu({
        {
            header = '[⚙]Tool Box',
            isMenuHeader = true,
        },
        {
            header = Lang['heaerd_repair'],
            txt = '',
            params = {
                event = "mr-toolbox:client:repairkit1",
            }
        },
        {
            header = Lang['heaerd_cleaning'],
            txt = '',
            params = {
                event = "mr-toolbox:client:cleaningkit",
            }
        },
        {
            header = Lang['heaerd_lockpick'],
            txt = '',
            params = {
                event = "mr-toolbox:client:lockpickkit",
            }
        },
        {
            header = Lang['heaerd_toolbox'],
            txt = '',
            params = {
                event = "mr-toolbox:toolbox",
            }
        },
        {
            header = Lang['heaerd_close'],
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

exports['qb-target']:AddTargetModel(Config.Object, {
    options = {
        {
            type = "client",
            event = "mr-toolbox:client:EliminarMesa",
            icon = Lang['heaerd_openicon'], 
            label = Lang['heaerd_pickup'],
        },
        {
            type = "client",
            event = "mr-toolbox:client:toolbox",
            icon = Lang['heaerd_openicon'], 
            label = Lang['heaerd_openlabel'],
            job = Config.Job,
        },
    },
    distance = 2.5
})