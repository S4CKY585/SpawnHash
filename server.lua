local allowedDiscordIDs = {
    "379314226608603139" --BTMN
}

local function getDiscordID(source)
    for _, identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(identifier, 1, 8) == "discord:" then
            return string.sub(identifier, 9)
        end
    end
    return nil
end

local function isAllowed(discordID)
    for _, id in ipairs(allowedDiscordIDs) do
        if id == discordID then
            return true
        end
    end
    return false
end

RegisterCommand('spawnhash', function(source, args, rawCommand)
    local discordID = getDiscordID(source)

    if not discordID or not isAllowed(discordID) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1Error', 'You do not have permission to use this command.' } })
        return
    end
    local hash = tonumber(args[1])

    if not hash then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1ERROR', 'Invalid hash provided.' } })
        return
    end

    -- Trigger client event to spawn the entity
    TriggerClientEvent('btmn:spawnHashInit', source, hash)
end)