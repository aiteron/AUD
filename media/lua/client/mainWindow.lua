if AUD == nil then AUD = {} end

AUD.textureButtonOn = getTexture("media/textures/AUD_mainMenuButton_On.png")
AUD.textureButtonOff = getTexture("media/textures/AUD_mainMenuButton_Off.png")

function AUD.hideWindow(self)
	ISCollapsableWindow.close(self);
	AUD.toolbarButton:setImage(AUD.textureButtonOff);
end

function AUD.showMainWindow(playerNum)
    AUD.mainWindowTabPanel = ISTabPanel:new(Core:getInstance():getScreenWidth() - 680, Core:getInstance():getScreenHeight() - 285, 640, 248);
    AUD.mainWindowTabPanel:initialise();
    AUD.mainWindowTabPanel:setAnchorBottom(true);
    AUD.mainWindowTabPanel:setAnchorRight(true);
    AUD.mainWindowTabPanel.target = self;
    AUD.mainWindowTabPanel:setEqualTabWidth(true)
    AUD.mainWindowTabPanel:setCenterTabs(true)
    AUD.mainWindow = AUD.mainWindowTabPanel:wrapInCollapsableWindow("Aiteron Userfriendly Debug");
    AUD.mainWindow.close = AUD.hideWindow;
    AUD.mainWindow.closeButton.onmousedown = AUD.hideWindow;
    AUD.mainWindow:setResizable(true);

    AUD.mainWindow:addToUIManager();
    AUD.toolbarButton:setImage(AUD.textureButtonOn);
end


function AUD.showMainWindowToggle()
    if AUD.mainWindow and AUD.mainWindow:getIsVisible() then
		AUD.mainWindow:close();
	else
		AUD.showMainWindow(getPlayer():getPlayerNum());
	end
end

function AUD.mainWindowButton()
    if AUD.toolBarButton then return end

    local movableBtn = ISEquippedItem.instance.movableBtn;
	AUD.toolbarButton = ISButton:new(-5, movableBtn:getY() + movableBtn:getHeight() + 110, 64, 64, "", nil, AUD.showMainWindowToggle);
	AUD.toolbarButton:setImage(AUD.textureButtonOff)
	AUD.toolbarButton:setDisplayBackground(false);
	AUD.toolbarButton.borderColor = {r=1, g=1, b=1, a=0.1};

	ISEquippedItem.instance:addChild(AUD.toolbarButton);
    ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), AUD.toolbarButton:getY() + 64));
end

Events.OnCreatePlayer.Add(AUD.mainWindowButton)