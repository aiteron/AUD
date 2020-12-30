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
        AUD.isMainWindowOpened = false
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
    local is_mainWindow = false

	local readFile = getModFileReader("AUD", "DebugWindowsState.txt", true)
    local scanLine = readFile:readLine()
    
    if scanLine == "TRUE" then
        is_mainWindow = true
    end

	while scanLine do
		scanLine = readFile:readLine()
		if not scanLine then break end
	end
	readFile:close()
    


    local mainWin_view = 2

    if is_mainWindow then
        AUD.showMainWindow()
        AUD.mainWindowTabPanel:activateView(activeViews[mainWin_view])
        AUD.mainWindow:setX(100)
        AUD.mainWindow:setY(100)
        AUD.mainWindow:setWidth(300)
        AUD.mainWindow:setHeight(500)
    end
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




-----------------------------

local function saveWindowsState()
    local writeFile = getModFileWriter("AUD", "DebugWindowsState.txt", true, false)
    
    --isRemoved

    if AUD.isMainWindowOpened then
        writeFile:write("TRUE".."\r\n");
    else
        writeFile:write("FALSE".."\r\n");
    end
    
	writeFile:close()
end

Events.OnSave.Add(saveWindowsState)


----- Custom Button

ISCustomButton = ISButton:derive("ISCustomButton");

function ISCustomButton:onRightMouseUp(x, y)
    print("YEAH")
end