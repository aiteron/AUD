if AUD == nil then AUD = {} end
AUD.Buttons = {}

AUD.Buttons.RED = {r=0.5, g=0.0, b=0.0, a=0.9}
AUD.Buttons.GREEN = {r=0.0, g=0.5, b=0.0, a=0.9}

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