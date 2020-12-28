require("AUDInit")
require("AUDButtons")
require("AUDUtils")

AUDVehicleTab = ISPanelJoypad:derive("AUDVehicleTab")

function AUDVehicleTab:initialise()
    ISPanelJoypad.initialise(self);

    self:instantiate()
    self:setAnchorRight(true)
    self:setAnchorLeft(true)
    self:setAnchorTop(true)
    self:setAnchorBottom(true)
    self:noBackground()
    self:setScrollChildren(true)
    self:addScrollBars()

    self.borderColor = {r=0, g=0, b=0, a=0};

    AUD.Buttons.addRepairVehicle(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addGetVehicleKey(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addSelectVehicle(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep*2, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addSelectThisVehicle(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep*3, AUD.Buttons.Width, AUD.Buttons.Height)
end

function AUDVehicleTab:render()

end


--- BUTTONS


function AUD.Buttons.addRepairVehicle(UIElement, x, y, width, height)
    local func = function(target, self)
        if AUD.Utils.selectedVehicle then
            AUD.Utils.selectedVehicle:repair()
        else
            getPlayer():Say("Vehicle not selected")
        end
    end

    local btn = ISButton:new(x, y, width, height, "Repair vehicle", nil, func)
    UIElement:addChild(btn);
end

function AUD.Buttons.addGetVehicleKey(UIElement, x, y, width, height)
    local func = function(target, self)
        if AUD.Utils.selectedVehicle then
            getPlayer():getInventory():AddItem(AUD.Utils.selectedVehicle:createVehicleKey())
        else
            getPlayer():Say("Vehicle not selected")
        end
    end

    local btn = ISButton:new(x, y, width, height, "Get key", nil, func)
    UIElement:addChild(btn);
end

function AUD.Buttons.addSelectVehicle(UIElement, x, y, width, height)
    local func = function(target, self)
        if AUD.Utils.isSelectVehicle then
            AUD.Utils.isHighlightSquareOn = false
            AUD.Utils.isSelectVehicle = false
        else
            AUD.Utils.isHighlightSquareOn = true
            AUD.Utils.isSelectVehicle = true
        end
    end

    local btn = ISButton:new(x, y, width, height, "Select vehicle", nil, func)
    UIElement:addChild(btn);
end

function AUD.Buttons.addSelectThisVehicle(UIElement, x, y, width, height)
    local func = function(target, self)
        local pl = getPlayer()
        local veh = pl:getVehicle()

        if veh then
            AUD.Utils.selectedVehicle = veh
            pl:Say(getText("IGUI_VehicleName" .. veh:getScript():getName()) .. " selected")
        else
            pl:Say("Player not in vehicle")
        end
    end

    local btn = ISButton:new(x, y, width, height, "Select this vehicle", nil, func)
    UIElement:addChild(btn);
end
