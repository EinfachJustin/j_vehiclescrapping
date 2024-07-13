Config = {}

-- Discord Webhook URL
Config.WebhookURL = 'IHRE_DISCORD_WEBHOOK_URL_HIER'

-- Ob Jobs im Menü angezeigt werden sollen
Config.ShowJobsInMenu = true

-- Kosten für das Verschrotten eines Fahrzeugs
Config.ScrapCost = 5000

-- Benachrichtigungsfunktionen
Config.ShowNotification = {}

-- Client-seitige Benachrichtigung
Config.ShowNotification.Client = function(message)
    ESX.ShowNotification(message)
end

-- Server-seitige Benachrichtigung
Config.ShowNotification.Server = function(source, message)
    TriggerClientEvent('esx:showNotification', source, message)
end

-- Standardsprache
Config.DefaultLocale = 'de'

-- Übersetzungen
Config.Locales = {
    ['de'] = {
        ['no_vehicles'] = 'Sie besitzen keine Fahrzeuge.',
        ['scrap_vehicle'] = 'Fahrzeug verschrotten',
        ['scrap_confirm'] = 'Möchten Sie dieses Fahrzeug wirklich verschrotten? Diese Aktion kostet $%d und kann nicht rückgängig gemacht werden.',
        ['scrap_success'] = 'Fahrzeug erfolgreich verschrottet. Kosten: $%d',
        ['scrap_error'] = 'Fehler beim Verschrotten des Fahrzeugs',
        ['not_enough_money'] = 'Sie haben nicht genug Geld. Kosten: $%d',
        ['my_vehicles'] = 'Meine Fahrzeuge'
    },
    ['en'] = {
        ['no_vehicles'] = 'You don\'t own any vehicles.',
        ['scrap_vehicle'] = 'Scrap Vehicle',
        ['scrap_confirm'] = 'Do you really want to scrap this vehicle? This action costs $%d and cannot be undone.',
        ['scrap_success'] = 'Vehicle successfully scrapped. Cost: $%d',
        ['scrap_error'] = 'Error scrapping the vehicle',
        ['not_enough_money'] = 'You don\'t have enough money. Cost: $%d',
        ['my_vehicles'] = 'My Vehicles'
    }
}

-- Funktion zum Abrufen von übersetzten Strings
function _(str, ...)
    local locale = Config.DefaultLocale
    if Config.Locales[locale] and Config.Locales[locale][str] then
        return string.format(Config.Locales[locale][str], ...)
    end
    return 'Translation missing: ' .. str
end
