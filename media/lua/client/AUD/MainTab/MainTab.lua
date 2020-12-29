require("AUD/Init")
require("AUD/Buttons")

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


function AUD.Buttons.addGodMode(UIElement, x, y, width, height)
    local func = function(target, self)
        local pl = getPlayer()
        if pl:isGodMod() then
            pl:setGodMod(false)
            self.backgroundColor = AUD.Buttons.RED
        else
            pl:setGodMod(true)
            self.backgroundColor = AUD.Buttons.GREEN
        end
        self:update()
    end

    local btn = ISButton:new(x, y, width, height, "God Mode", nil, func);
    if getPlayer():isGodMod() then
        btn.backgroundColor = AUD.Buttons.GREEN
    else
        btn.backgroundColor = AUD.Buttons.RED
    end

    UIElement:addChild(btn);
end

function AUD.Buttons.addGhostMode(UIElement, x, y, width, height)
    local func = function(target, self)
        local pl = getPlayer()
        if pl:isGhostMode() then
            pl:setGhostMode(false)
            self.backgroundColor = AUD.Buttons.RED
        else
            pl:setGhostMode(true)
            self.backgroundColor = AUD.Buttons.GREEN
        end
        self:update()
    end

    local btn = ISButton:new(x, y, width, height, "Ghost Mode", nil, func);
    if getPlayer():isGhostMode() then
        btn.backgroundColor = AUD.Buttons.GREEN
    else
        btn.backgroundColor = AUD.Buttons.RED
    end

    UIElement:addChild(btn);
end

function AUD.Buttons.addNoClip(UIElement, x, y, width, height)
    local func = function(target, self)
        local pl = getPlayer()
        if pl:isNoClip() then
            pl:setNoClip(false)
            self.backgroundColor = AUD.Buttons.RED
        else
            pl:setNoClip(true)
            self.backgroundColor = AUD.Buttons.GREEN
        end
        self:update()
    end

    local btn = ISButton:new(x, y, width, height, "NoClip", nil, func);
    if getPlayer():isNoClip() then
        btn.backgroundColor = AUD.Buttons.GREEN
    else
        btn.backgroundColor = AUD.Buttons.RED
    end

    UIElement:addChild(btn);
end

function AUD.Buttons.addInspector(UIElement, x, y, width, height)
    local func = function(target, self)
        AUD.inspectorWindowTabPanel = AUDInspector:new(Core:getInstance():getScreenWidth() - 680, Core:getInstance():getScreenHeight() - 620, 640, 248);
        AUD.inspectorWindowTabPanel:initialise()
    end

    local btn = ISButton:new(x, y, width, height, "Inspector", nil, func);
    UIElement:addChild(btn);
end


function AUD.Buttons.addLuaFileExplorer(UIElement, x, y, width, height)
    local func = function(target, self)
        panel2 = CustomLuaFileBrowser:new(getCore():getScreenWidth() - 550, getCore():getScreenHeight() - 300 - 300, 500, 300);
        panel2:initialise();
        panel2:addToUIManager();
    end

    local btn = ISButton:new(x, y, width, height, "Lua File Explorer", nil, func);
    UIElement:addChild(btn);
end
