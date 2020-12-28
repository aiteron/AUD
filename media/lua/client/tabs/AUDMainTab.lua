

AUDMainTab = ISPanelJoypad:derive("AUDMainTab")

function AUDMainTab:initialise()
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

    AUD.Buttons.addGodMode(self, 10, 10, 100, 20)
    AUD.Buttons.addGhostMode(self, 10, 10 + 30, 100, 20)
    AUD.Buttons.addNoClip(self, 10, 10 + 30*2, 100, 20)
end

function AUDMainTab:render()

end