Config = {}

Config.WebhookURL = 'IHRE_DISCORD_WEBHOOK_URL_HIER'
Config.ShowJobsInMenu = true
Config.ScrapCost = 5000

Config.Locales = {
    ['en'] = {
        ['no_vehicles'] = 'You don\'t own any vehicles.',
        ['scrap_vehicle'] = 'Scrap Vehicle',
        ['scrap_confirm'] = 'Do you really want to scrap this vehicle? This action costs $%d and cannot be undone.',
        ['my_vehicles'] = 'My Vehicles',
        ['job'] = 'Job',
        ['civilian'] = 'Civilian',
        ['model'] = 'Model',
        ['plate'] = 'Plate',
        ['invalid_plate'] = 'Invalid vehicle license plate.',
        ['scrap_success'] = 'Vehicle successfully scrapped. Cost: $%d',
        ['scrap_error'] = 'Error scrapping the vehicle',
        ['not_enough_money'] = 'You don\'t have enough money. Cost: $%d',
    },
    ['de'] = {
        ['no_vehicles'] = 'Sie besitzen keine Fahrzeuge.',
        ['scrap_vehicle'] = 'Fahrzeug verschrotten',
        ['scrap_confirm'] = 'Möchten Sie dieses Fahrzeug wirklich verschrotten? Diese Aktion kostet $%d und kann nicht rückgängig gemacht werden.',
        ['my_vehicles'] = 'Meine Fahrzeuge',
        ['job'] = 'Job',
        ['civilian'] = 'Zivilist',
        ['model'] = 'Modell',
        ['plate'] = 'Kennzeichen',
        ['invalid_plate'] = 'Ungültiges Fahrzeugkennzeichen.',
        ['scrap_success'] = 'Fahrzeug erfolgreich verschrottet. Kosten: $%d',
        ['scrap_error'] = 'Fehler beim Verschrotten des Fahrzeugs',
        ['not_enough_money'] = 'Sie haben nicht genug Geld. Kosten: $%d',
    }
}

Config.DefaultLocale = 'en'  -- oder 'en' für Englisch
