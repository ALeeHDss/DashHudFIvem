
-- Función para inicializar el speedometer
function initSpeedometer()
    -- Cargar el archivo HTML
    LoadResourceFile("speedometer", "speedometer.html")

    -- Crear un navegador web para mostrar el archivo HTML
    local browser = CreateBrowser(0.0, 0.0, 0.0, 0.0, false, false, false, true)
    SetBrowserUrl(browser, "http://speedometer/")

    -- Actualizar la velocidad del vehículo en el metadato del recurso
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)

            local playerPed = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if DoesEntityExist(vehicle) then
                local speed = GetEntitySpeed(vehicle) * 3.6
                SetResourceMetadata(GetCurrentResourceName(), "speed", 0, speed)
            else
                SetResourceMetadata(GetCurrentResourceName(), "speed", 0, nil)
            end
        end
    end)
end

-- Llamar a la función initSpeedometer una vez al iniciar el juego
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    initSpeedometer()
end)