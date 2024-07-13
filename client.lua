if not Config then
    print("Config nicht geladen. Bitte überprüfen Sie Ihre config.lua und fxmanifest.lua")
    return
end
local ESX = exports["es_extended"]:getSharedObject()
local _ = _

local function getVehicleLabel(model)
    return GetLabelText(GetDisplayNameFromVehicleModel(model))
end

local function openVehicleMenu()
    ESX.TriggerServerCallback('getOwnedVehicles', function(vehicles)
        if not vehicles or #vehicles == 0 then
            Config.ShowNotification.Client(_('no_vehicles'))
            return
        end

        local options = {}
        for _, vehicle in ipairs(vehicles) do
            local vehicleData = json.decode(vehicle.vehicle)
            local vehicleLabel = getVehicleLabel(vehicleData.model)
            local jobInfo = Config.ShowJobsInMenu and vehicle.job ~= 'civ' and (' - Job: ' .. vehicle.job) or ''
            table.insert(options, {
                title = vehicleLabel .. ' (' .. vehicle.plate .. ')' .. jobInfo,
                description = 'Modell: ' .. vehicleLabel .. ', Kennzeichen: ' .. vehicle.plate .. jobInfo,
                icon = 'car',
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = 'Fahrzeug verschrotten',
                        content = string.format('Möchten Sie dieses Fahrzeug wirklich verschrotten? Diese Aktion kostet $%d und kann nicht rückgängig gemacht werden.', Config.ScrapCost),
                        centered = true,
                        cancel = true
                    })
                    
                    if alert == 'confirm' then
                        TriggerServerEvent('scrapeVehicle', vehicle.plate)
                    end
                end
            })
        end

        lib.registerContext({
            id = 'vehicle_menu',
            title = 'Meine Fahrzeuge',
            options = options
        })

        lib.showContext('vehicle_menu')
    end)
end


RegisterCommand('myvehicles', function()
    openVehicleMenu()
end, false)

local function _(str, ...)
    local locale = Config.DefaultLocale
    if Config.Locales[locale] and Config.Locales[locale][str] then
        return string.format(Config.Locales[locale][str], ...)
    end
    return 'Translation missing: ' .. str
end
