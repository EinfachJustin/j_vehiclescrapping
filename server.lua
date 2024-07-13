local ESX = exports["es_extended"]:getSharedObject()

-- Function to get localized text
local function getLocalizedText(key, ...)
    local locale = Config.DefaultLocale
    if Config.Locales[locale] and Config.Locales[locale][key] then
        return string.format(Config.Locales[locale][key], ...)
    end
    return key
end

local function sendToDiscord(message)
    if Config.WebhookURL and Config.WebhookURL ~= '' then
        PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    else
        print("Discord Webhook not configured or empty.")
    end
end

ESX.RegisterServerCallback('getOwnedVehicles', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
   
    exports.oxmysql:execute('SELECT plate, vehicle, IFNULL(job, "civ") as job FROM owned_vehicles WHERE owner = ?', {xPlayer.identifier}, function(result)
        cb(result)
    end)
end)

RegisterNetEvent('scrapeVehicle')
AddEventHandler('scrapeVehicle', function(plate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("Error: Player not found for source:", source)
        return
    end

    if not plate or type(plate) ~= "string" or plate == "" then
        print("Error: Invalid license plate:", plate)
        xPlayer.showNotification(getLocalizedText('invalid_plate'))
        return
    end

    if xPlayer.getMoney() >= Config.ScrapCost then
        exports.oxmysql:execute('DELETE FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate}, function(result)
            if result and result.affectedRows and result.affectedRows > 0 then
                xPlayer.removeMoney(Config.ScrapCost)
                xPlayer.showNotification(getLocalizedText('scrap_success', Config.ScrapCost))
               
                -- Discord Webhook
                local message = string.format('Player %s (ID: %s) has scrapped a vehicle with plate %s. Cost: $%d',
                    xPlayer.getName(), source, plate, Config.ScrapCost)
                sendToDiscord(message)
            else
                xPlayer.showNotification(getLocalizedText('scrap_error'))
                print("Error: Vehicle not found or not deleted. Player:", xPlayer.identifier, "Plate:", plate)
            end
        end)
    else
        xPlayer.showNotification(getLocalizedText('not_enough_money', Config.ScrapCost))
    end
end)
