local ESX = exports["es_extended"]:getSharedObject()

local function getLocalizedText(key, ...)
    local locale = Config.DefaultLocale
    if Config.Locales[locale] and Config.Locales[locale][key] then
        return string.format(Config.Locales[locale][key], ...)
    end
    return key
end

local function getVehicleLabel(model)
    return GetLabelText(GetDisplayNameFromVehicleModel(model))
end

local function openVehicleMenu()
    ESX.TriggerServerCallback('getOwnedVehicles', function(vehicles)
        if not vehicles or #vehicles == 0 then
            ESX.ShowNotification(getLocalizedText('no_vehicles'))
            return
        end

        local options = {}
        for _, vehicle in ipairs(vehicles) do
            local vehicleData = json.decode(vehicle.vehicle)
            local vehicleLabel = getVehicleLabel(vehicleData.model)
            local jobInfo = ''
            if Config.ShowJobsInMenu then
                if vehicle.job and vehicle.job ~= '' and vehicle.job ~= 'civ' then
                    jobInfo = ' - ' .. getLocalizedText('job') .. ': ' .. vehicle.job
                else
                    jobInfo = ' - ' .. getLocalizedText('job') .. ': ' .. getLocalizedText('civilian')
                end
            end
            
            table.insert(options, {
                title = vehicleLabel .. ' (' .. vehicle.plate .. ')' .. jobInfo,
                description = getLocalizedText('model') .. ': ' .. vehicleLabel .. ', ' .. getLocalizedText('plate') .. ': ' .. vehicle.plate .. jobInfo,
                icon = 'car',
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = getLocalizedText('scrap_vehicle'),
                        content = getLocalizedText('scrap_confirm', Config.ScrapCost),
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
            title = getLocalizedText('my_vehicles'),
            options = options
        })

        lib.showContext('vehicle_menu')
    end)
end

RegisterCommand('myvehicles', function()
    openVehicleMenu()
end, false)
