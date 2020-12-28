require("AUDInit")
AUD.Utils = {}

AUD.Utils.isHighlightSquareOn = false

AUD.Utils.isSelectVehicle = false
AUD.Utils.selectedVehicle = nil

function AUD.Utils.highlightSquare()
    if AUD.Utils.isHighlightSquareOn then 
        local z = getPlayer():getZ()
        local x, y = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), z)
        
		local sq = getCell():getGridSquare(math.floor(x), math.floor(y), z)
        if sq ~= nil then
            local objects =  sq:getObjects()
            for i=0, objects:size()-1 do
                local obj = objects:get(i)
				obj:setHighlighted(true)
            end
		end
	end
end

Events.OnMouseMove.Add(AUD.Utils.highlightSquare)




function AUD.Utils.onClick()    
    if AUD.Utils.isSelectVehicle then
        local z = getPlayer():getZ()
        local x, y = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), z)
        
		local sq = getCell():getGridSquare(math.floor(x), math.floor(y), z)
        local vehicle = sq:getVehicleContainer()
        if vehicle ~= nil then
            AUD.Utils.selectedVehicle = vehicle
            AUD.Utils.isHighlightSquareOn = false
            AUD.Utils.isSelectVehicle = false
            getPlayer():Say(getText("IGUI_VehicleName" .. vehicle:getScript():getName()) .. " selected")
        end
    end
end

Events.OnMouseDown.Add(AUD.Utils.onClick)