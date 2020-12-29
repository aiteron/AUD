require("AUDInit")
AUD.Buttons = {}

AUD.Buttons.RED = {r=0.5, g=0.0, b=0.0, a=0.9}
AUD.Buttons.GREEN = {r=0.0, g=0.5, b=0.0, a=0.9}

AUD.Buttons.Width = 150
AUD.Buttons.Height = 20
AUD.Buttons.LeftIndent = 10
AUD.Buttons.TopIndent = 10
AUD.Buttons.VerticalInterval = 10
AUD.Buttons.HorizontalInterval = 10
AUD.Buttons.VerticalStep = AUD.Buttons.Height + AUD.Buttons.VerticalInterval

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
    btn.textColor = {r=0.3, g=0.3, b=0.7, a=1.0}
    btn.backgroundColor = {r=0.0, g=0.0, b=0.1, a=1.0}

    UIElement:addChild(btn);
end

