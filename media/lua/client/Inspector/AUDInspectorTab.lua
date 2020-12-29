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
end

function AUDInspectorTab:render()

end