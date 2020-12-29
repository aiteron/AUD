--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

if customDebugScenarios == nil then
    customDebugScenarios = {}
end

CustomDebugScenarios = ISPanel:derive("CustomDebugScenarios");

selectedDebugScenario = nil;

function CustomDebugScenarios:createChildren()
    self.header = ISLabel:new(self.width / 2, 0, 40, "CUSTOM SCENARIOS", 1,1,1,1, UIFont.Large, true);
    self.header.center = true;
    self:addChild(self.header);

    local listY = self.header:getBottom()
    self.listbox = ISScrollingListBox:new(16, listY, self:getWidth()-32, self:getHeight()-16-listY);
    self.listbox:initialise();
    self.listbox:instantiate();
    self.listbox:setFont(UIFont.Medium, 2);
    self.listbox.drawBorder = true;
    self.listbox.doDrawItem = CustomDebugScenarios.drawItem;
    self.listbox:setOnMouseDownFunction(self, CustomDebugScenarios.onClickOption);
    self:addChild(self.listbox);

    for k,v in pairs(customDebugScenarios) do
        self.listbox:addItem(v.name, k);
    end

    self:setMaxDrawHeight(self.header:getBottom())
end

function CustomDebugScenarios:prerender()
    local height = self:getHeight();
    if self:getMaxDrawHeight() ~= -1 then
        height = self:getMaxDrawHeight();
    end
    if self.background then
        self:drawRectStatic(0, 0, self.width, height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        self:drawRectBorderStatic(0, 0, self.width, height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    end
end

function CustomDebugScenarios:drawItem(y, item, alt)

    if self.mouseoverselected == item.index then
        self:drawRect(0, y, self:getWidth(), item.height-1, 0.25,0.5,0.5,0.5);
    end
    self:drawRectBorder(0, y + item.height - 1, self:getWidth(), 1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    -- the name of the story
    self:drawText(item.text, 16, y + (item.height - FONT_HGT_MEDIUM) / 2, 0.6, 0.7, 0.9, 1.0, UIFont.Medium);

    return y+item.height;
end

function CustomDebugScenarios:onMouseMove(dx, dy)
    ISPanel.onMouseMove(self, dx, dy);
    self:setMaxDrawHeight(self:getHeight());
end

function CustomDebugScenarios:onMouseMoveOutside(dx, dy)
    ISPanel.onMouseMoveOutside(self, dx, dy);
    self:setMaxDrawHeight(self.header:getBottom());
end

function CustomDebugScenarios:new (x, y, width, height)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.backgroundColor = {r=0.0, g=0.05, b=0.1, a=1.0};
    o.borderColor = {r=1, g=1, b=1, a=0.7};

    return o
end

function CustomDebugScenarios:onClickOption(option)

    local scenario = customDebugScenarios[option];

    self:launchScenario(scenario);
end

function CustomDebugScenarios:launchScenario(scenario)
    MainScreen.instance:setBeginnerPreset();
    
    if(scenario ~= nil) then
        selectedDebugScenario = scenario;
    end
    
    if selectedDebugScenario.setSandbox ~= nil then
        selectedDebugScenario.setSandbox();
    end
    local worldName = ZombRand(100000)..ZombRand(100000)..ZombRand(100000)..ZombRand(100000);
    getWorld():setWorld(worldName);
    createWorld(worldName);
    GameWindow.doRenderEvent(false);
    Events.OnNewGame.Add(CustomDebugScenarios.ongamestart);
    Events.LoadGridsquare.Add(CustomDebugScenarios.onloadgs);
    forceChangeState(GameLoadingState.new());
    CustomDebugScenarios.instance:setVisible(false);
end

function doDebugScenarios()
    local x = getCore():getScreenWidth() / 2;
    local y = getCore():getScreenHeight() / 2;
    x = x - 250 - 100;
    y = y - 250;
    local debug = DebugScenarios:new(x, y, 400, 500);
    MainScreen.instance:addChild(debug);
    DebugScenarios.instance = debug;

    -- check if any scenarios have the forceLaunch option, in this case we launch it directly, save more clicks!
    for i,v in pairs(debugScenarios) do
        if v.forceLaunch and getDebugOptions():getBoolean("DebugScenario.ForceLaunch") then
            DebugScenarios.instance:launchScenario(v);
        end
    end


    local debug = CustomDebugScenarios:new(x + 410, y, 400, 500);
    MainScreen.instance:addChild(debug);
    CustomDebugScenarios.instance = debug;

    -- check if any scenarios have the forceLaunch option, in this case we launch it directly, save more clicks!
    for i,v in pairs(debugScenarios) do
        if v.forceLaunch and getDebugOptions():getBoolean("DebugScenario.ForceLaunch") then
            CustomDebugScenarios.instance:launchScenario(v);
        end
    end
end
