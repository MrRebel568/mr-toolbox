local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.SpawnItem, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mr-toolbox:client:SpawnarMesa', source)
    end
end)

RegisterServerEvent('mr-toolbox:server:repairkit')
AddEventHandler('mr-toolbox:server:repairkit', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1

        if  Player.Functions.AddItem('repairkit', quantity) then
        TriggerClientEvent(Config.InventoryTrigger, source, QBCore.Shared.Items["repairkit"], "add")
    end
end)

RegisterServerEvent('mr-toolbox:server:cleaning')
AddEventHandler('mr-toolbox:server:cleaning', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1

       if Player.Functions.AddItem('cleaningkit', quantity) then
        TriggerClientEvent(Config.InventoryTrigger, source, QBCore.Shared.Items["cleaningkit"], "add")
    end
end)

RegisterServerEvent('mr-toolbox:server:lockpick')
AddEventHandler('mr-toolbox:server:lockpick', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1

       if Player.Functions.AddItem('lockpick', quantity) then
        TriggerClientEvent(Config.InventoryTrigger, source, QBCore.Shared.Items["lockpick"], "add")
    end
end)
