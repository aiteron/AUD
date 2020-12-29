require("AUDInit")
require("AUDButtons")

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

    AUD.Buttons.addGodMode(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addGhostMode(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addNoClip(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep*2, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addInspector(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep*3, AUD.Buttons.Width, AUD.Buttons.Height)
    AUD.Buttons.addLuaFileExplorer(self, AUD.Buttons.LeftIndent, AUD.Buttons.TopIndent + AUD.Buttons.VerticalStep*4, AUD.Buttons.Width, AUD.Buttons.Height)
end

function AUDMainTab:render()

end