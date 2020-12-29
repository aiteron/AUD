require("AUD/Inspector/Inspector.lua")


local function showPlayerStats()
    local player = getPlayer()

    AUD.insp("Player", "Player position:", math.floor(player:getX()*10)/10, math.floor(player:getY()*10)/10)

    local vehicle = player:getVehicle()

    local x = "None"
    local y = "None"
    local vehName = "None"

    if vehicle then
        x = math.floor(vehicle:getX()*10)/10
        y = math.floor(vehicle:getY()*10)/10
        vehName = vehicle:getScript():getName()
    end

    AUD.insp("Player", "Vehicle:", vehName)
    AUD.insp("Player", "Vehicle position:", x, y, 4534, 3333, 2222)
end


Events.OnTick.Add(showPlayerStats)