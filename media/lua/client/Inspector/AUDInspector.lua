require("AUDInit")
require("AUDButtons")
AUD.Inspector = {}
AUD.Inspector.Tabs = {}
AUD.Inspector.TabsData = {}

AUDInspector = ISTabPanel:derive("AUDInspector")

function AUDInspector:initialise()
    ISTabPanel.initialise(self);

    self:setAnchorBottom(true);
    self:setAnchorRight(true);
    self.target = self;
    self:setEqualTabWidth(true)
    self:setCenterTabs(true)
    AUD.inspectorWindow = self:wrapInCollapsableWindow("Aiteron Userfriendly Debug");
    
    local closeFunc = function(obj)
        ISCollapsableWindow.close(obj);
    end
    
    AUD.inspectorWindow.close = closeFunc
    AUD.inspectorWindow.closeButton.onmousedown = closeFunc
    AUD.inspectorWindow:setResizable(true);

    AUD.inspectorWindow:addToUIManager();

    for tabName, values in pairs(AUD.Inspector.TabsData) do
        AUD.Inspector.Tabs[tabName] = AUDInspectorTab:new(0, 48, AUD.inspectorWindow:getWidth(), AUD.inspectorWindow:getHeight() - AUD.inspectorWindow.nested.tabHeight)
        AUD.Inspector.Tabs[tabName]:initialise()
        AUD.Inspector.Tabs[tabName].values = AUD.Inspector.TabsData[tabName]
        AUD.inspectorWindow.nested:addView(tabName, AUD.Inspector.Tabs[tabName])
    end
end


--------

function AUD.insp(tabName, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    if AUD.Inspector.TabsData[tabName] == nil then
        AUD.Inspector.TabsData[tabName] = {}
        
        if AUD.inspectorWindow ~= nil then 
            AUD.Inspector.Tabs[tabName] = AUDInspectorTab:new(0, 48, AUD.inspectorWindow:getWidth(), AUD.inspectorWindow:getHeight() - AUD.inspectorWindow.nested.tabHeight)
            AUD.Inspector.Tabs[tabName]:initialise()
            AUD.Inspector.Tabs[tabName].values = AUD.Inspector.TabsData[tabName]
            AUD.inspectorWindow.nested:addView(tabName, AUD.Inspector.Tabs[tabName])
        end
    end

    local t = {}
    table.insert(t, arg1)
    table.insert(t, arg2)
    table.insert(t, arg3)
    table.insert(t, arg4)
    table.insert(t, arg5)
    table.insert(t, arg6)
    table.insert(t, arg7)

    local lastNotNil = 0

    if arg1 ~= nil then lastNotNil = 1 end
    if arg2 ~= nil then lastNotNil = 2 end
    if arg3 ~= nil then lastNotNil = 3 end
    if arg4 ~= nil then lastNotNil = 4 end
    if arg5 ~= nil then lastNotNil = 5 end
    if arg6 ~= nil then lastNotNil = 6 end
    if arg7 ~= nil then lastNotNil = 7 end

    for i=1, lastNotNil do
        if t[i] == nil then
            t[i] = "nil"
        end
    end

    table.insert(AUD.Inspector.TabsData[tabName], t)
end

