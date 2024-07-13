
local ESX = exports["es_extended"]:getSharedObject()

local function sendToDiscord(message)
    if Config.WebhookURL and Config.WebhookURL ~= '' then
        PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    else
        print("Discord Webhook nicht konfiguriert oder leer.")
    end
end


ESX.RegisterServerCallback('getOwnedVehicles', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    exports.oxmysql:execute('SELECT plate, vehicle, job FROM owned_vehicles WHERE owner = ?', {xPlayer.identifier}, function(result)
        cb(result)
    end)
end)

RegisterNetEvent('scrapeVehicle')
AddEventHandler('scrapeVehicle', function(plate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("Fehler: Spieler nicht gefunden für source:", source)
        return
    end

    if not plate or type(plate) ~= "string" or plate == "" then
        print("Fehler: Ungültiges Kennzeichen:", plate)
        Config.ShowNotification.Server(source, "Ungültiges Fahrzeugkennzeichen.")
        return
    end

    if xPlayer.getMoney() >= Config.ScrapCost then
        exports.oxmysql:execute('DELETE FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate}, function(result)
            if result and result.affectedRows and result.affectedRows > 0 then
                xPlayer.removeMoney(Config.ScrapCost)
                Config.ShowNotification.Server(source, _('scrap_success', Config.ScrapCost))
                
                -- Discord Webhook
                local message = string.format('Spieler %s (ID: %s) hat ein Fahrzeug mit dem Kennzeichen %s verschrottet. Kosten: $%d', 
                    xPlayer.getName(), source, plate, Config.ScrapCost)
                sendToDiscord(message)
            else
                Config.ShowNotification.Server(source, _('scrap_error'))
                print("Fehler: Fahrzeug nicht gefunden oder nicht gelöscht. Spieler:", xPlayer.identifier, "Kennzeichen:", plate)
            end
        end)
    else
        Config.ShowNotification.Server(source, _('not_enough_money', Config.ScrapCost))
    end
end)
