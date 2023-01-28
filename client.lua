local jumpHeight = 2.0 -- Można edytować wysokość skoku tutaj
local jumpCooldown = 5000 -- Można edytować czas cooldownu tutaj (w milisekundach)
local lastJump = 0
local showMessage = true -- Można włączyć/wyłączyć komunikat tutaj

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) then
            if IsControlJustPressed(1, 38) then
                local currentTime = GetGameTimer()
                if currentTime - lastJump >= jumpCooldown then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    ApplyForceToEntity(vehicle, 1, 0.0, 0.0, jumpHeight, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                    lastJump = currentTime
                else
                    if showMessage then
                        local remainingTime = math.floor((jumpCooldown - (currentTime - lastJump)) / 1000)
                        TriggerEvent("chat:addMessage", { args = {"^1Musisz odczekać jeszcze " .. remainingTime .. " sekund przed ponownym użyciem skoku."}})
                    end
                end
            end
        end
    end
end)
