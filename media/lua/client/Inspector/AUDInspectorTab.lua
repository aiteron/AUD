require("AUDInit")
require("AUDButtons")

AUDInspectorTab = ISPanelJoypad:derive("AUDInspectorTab")

function AUDInspectorTab:initialise()
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

    -- buttons here
end

function AUDInspectorTab:render()
    local step = 1
    for _, values in pairs(self.values) do
        local text = ""
        text = text .. values[1] .. "  "
        
        for i=2, #values do
            if i == #values then
                text = text .. values[i]
            else
                text = text .. values[i] .. " | "            
            end
        end

        self:drawText(text, 3, step, 1, 1, 1, 1, UIFont.Small);
        step = step + 15
    end
end