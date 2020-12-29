function DebugScenarios:createChildren()
    self.header = ISLabel:new(self.width / 2, 0, 40, "SCENARIOS", 1,1,1,1, UIFont.Large, true);
    self.header.center = true;
    self:addChild(self.header);

    local listY = self.header:getBottom()
    self.listbox = ISScrollingListBox:new(16, listY, self:getWidth()-32, self:getHeight()-16-listY);
    self.listbox:initialise();
    self.listbox:instantiate();
    self.listbox:setFont(UIFont.Medium, 2);
    self.listbox.drawBorder = true;
    self.listbox.doDrawItem = DebugScenarios.drawItem;
    self.listbox:setOnMouseDownFunction(self, DebugScenarios.onClickOption);
    self:addChild(self.listbox);

    self.listbox:addItem("Default scenarios", "DEFAULT");

    for k,v in pairs(debugScenarios) do
        if v.isCustom then
            self.listbox:addItem(v.name, k);
        end
    end

    self:setMaxDrawHeight(self.header:getBottom())
end


function DebugScenarios:onClickOption(option)
    if option == "DEFAULT" then
        self.listbox:clear()
        for k,v in pairs(debugScenarios) do
            self.listbox:addItem(v.name, k);
        end
    else
        local scenario = debugScenarios[option];
        self:launchScenario(scenario);
    end
end