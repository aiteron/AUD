require("AUD/Init")

AUD.textureButtonOn = getTexture("media/textures/AUD_mainMenuButton_On.png")
AUD.textureButtonOff = getTexture("media/textures/AUD_mainMenuButton_Off.png")

local activeView = 1
local activeViews = {
        [1] = "Main",
        [2] = "Vehicle",
    }


function AUD.showMainWindow()
    AUD.mainWindowTabPanel = ISTabPanel:new(Core:getInstance():getScreenWidth() - 220, Core:getInstance():getScreenHeight() - 290, 170, 238);
    AUD.mainWindowTabPanel:initialise();
    AUD.mainWindowTabPanel:setAnchorBottom(true);
    AUD.mainWindowTabPanel:setAnchorRight(true);
    AUD.mainWindowTabPanel.target = self;
    AUD.mainWindowTabPanel:setEqualTabWidth(true)
    AUD.mainWindowTabPanel:setCenterTabs(true)
    AUD.mainWindow = AUD.mainWindowTabPanel:wrapInCollapsableWindow("AUD");
    
    local closeFunc = function(obj)
        activeView = AUD.mainWindowTabPanel:getActiveViewIndex()
        ISCollapsableWindow.close(obj);
        AUD.toolbarButton:setImage(AUD.textureButtonOff);
        AUD.mainWindow:setRemoved(true)
    end
    
    AUD.mainWindow.close = closeFunc
    AUD.mainWindow.closeButton.onmousedown = closeFunc

    AUD.mainWindow:setResizable(true);

    AUD.loadMainWindowTabs()

    AUD.mainWindow:addToUIManager();
    AUD.toolbarButton:setImage(AUD.textureButtonOn);
end



function AUD.loadMainWindowTabs()
    AUD.mainTab = AUDMainTab:new(0, 48, AUD.mainWindow:getWidth(), AUD.mainWindow:getHeight() - AUD.mainWindow.nested.tabHeight)
    AUD.mainTab:initialise()
    AUD.mainWindow.nested:addView("Main", AUD.mainTab)

    AUD.vehicleTab = AUDVehicleTab:new(0, 48, AUD.mainWindow:getWidth(), AUD.mainWindow:getHeight() - AUD.mainWindow.nested.tabHeight)
    AUD.vehicleTab:initialise()
    AUD.mainWindow.nested:addView("Vehicle", AUD.vehicleTab)
end


function AUD.showMainWindowToggle()
    if AUD.mainWindow and AUD.mainWindow:getIsVisible() then
        AUD.mainWindow:close();
	else
        AUD.showMainWindow();
        AUD.mainWindowTabPanel:activateView(activeViews[activeView])
        AUD.isMainWindowOpened = true
	end
end

local function restoreWindows()
    local readFile = getModFileReader("AUD", "DebugWindowsState.txt", true)
    
    if readFile:readLine() == "TRUE" then
        AUD.showMainWindow()

        AUD.mainWindowTabPanel:activateView(activeViews[tonumber(readFile:readLine())])
        AUD.mainWindow:setX(tonumber(readFile:readLine()))
        AUD.mainWindow:setY(tonumber(readFile:readLine()))
        AUD.mainWindow:setWidth(tonumber(readFile:readLine()))
        AUD.mainWindow:setHeight(tonumber(readFile:readLine()))
    end

    if readFile:readLine() == "TRUE" then
        local x = tonumber(readFile:readLine())
        local y = tonumber(readFile:readLine())
        local width = tonumber(readFile:readLine())
        local height = tonumber(readFile:readLine())
        
        AUD.inspectorWindowTabPanel = AUDInspector:new(x, y, width, height)
        AUD.inspectorWindowTabPanel:initialise()
    end

    if readFile:readLine() == "TRUE" then
        local x = tonumber(readFile:readLine())
        local y = tonumber(readFile:readLine())
        local width = tonumber(readFile:readLine())
        local height = tonumber(readFile:readLine())
        
        AUD.luaFileBrowser = CustomLuaFileBrowser:new(x, y, width, height);
        AUD.luaFileBrowser:initialise();
        AUD.luaFileBrowser:addToUIManager();
    end


	readFile:close()
end


function AUD.mainWindowButton()
    if AUD.toolBarButton then return end

    local movableBtn = ISEquippedItem.instance.movableBtn;
	AUD.toolbarButton = ISCustomButton:new(-9, movableBtn:getY() + movableBtn:getHeight() + 70, 64, 64, "", nil, AUD.showMainWindowToggle);
	AUD.toolbarButton:setImage(AUD.textureButtonOff)
	AUD.toolbarButton:setDisplayBackground(false);
    AUD.toolbarButton.borderColor = {r=1, g=1, b=1, a=0.1};

	ISEquippedItem.instance:addChild(AUD.toolbarButton);
    ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), AUD.toolbarButton:getY() + 64));

    restoreWindows()
end

Events.OnCreatePlayer.Add(AUD.mainWindowButton)


----- Custom Button

ISCustomButton = ISButton:derive("ISCustomButton");

function ISCustomButton:onRightMouseUp(x, y)
    local writeFile = getModFileWriter("AUD", "DebugWindowsState.txt", true, false)

    if AUD.mainWindow and not AUD.mainWindow:isRemoved() then
        writeFile:write("TRUE".."\r\n");
        writeFile:write(activeView .. "\r\n");
        writeFile:write(AUD.mainWindow.x .. "\r\n");
        writeFile:write(AUD.mainWindow.y .. "\r\n");
        writeFile:write(AUD.mainWindow.width .. "\r\n");
        writeFile:write(AUD.mainWindow.height .. "\r\n");
    else
        writeFile:write("FALSE".."\r\n");
    end

    if AUD.inspectorWindow and not AUD.inspectorWindow:isRemoved() then
        writeFile:write("TRUE".."\r\n");
        writeFile:write(AUD.inspectorWindow.x .. "\r\n");
        writeFile:write(AUD.inspectorWindow.y .. "\r\n");
        writeFile:write(AUD.inspectorWindow.width .. "\r\n");
        writeFile:write(AUD.inspectorWindow.height .. "\r\n");
    else
        writeFile:write("FALSE".."\r\n");
    end

    if AUD.luaFileBrowser and not AUD.luaFileBrowser:isRemoved() then
        writeFile:write("TRUE".."\r\n");
        writeFile:write(AUD.luaFileBrowser.x .. "\r\n");
        writeFile:write(AUD.luaFileBrowser.y .. "\r\n");
        writeFile:write(AUD.luaFileBrowser.width .. "\r\n");
        writeFile:write(AUD.luaFileBrowser.height .. "\r\n");
    else
        writeFile:write("FALSE".."\r\n");
    end
    
    writeFile:close()
    
    getPlayer():Say("Window layout saved")
end