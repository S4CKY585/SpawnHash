RegisterNetEvent('btmn:spawnHashInit')
AddEventHandler('btmn:spawnHashInit', function(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(100)
    end

    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    local entity = CreateObject(hash, playerPos.x, playerPos.y, playerPos.z, true, false, true)
    
    if not DoesEntityExist(entity) then
        entity = CreateVehicle(hash, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, false)
    end
    
    if not DoesEntityExist(entity) then
        entity = CreatePed(4, hash, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, false)
    end

    if DoesEntityExist(entity) then
        SetEntityAsNoLongerNeeded(entity)
        TriggerEvent('chat:addMessage', { args = { '^2SUCCESS', 'Entity spawned with hash: ' .. hash } })
    else
        TriggerEvent('chat:addMessage', { args = { '^1ERROR', 'Failed to spawn entity with hash: ' .. hash } })
    end
end)