require "ISUI/ISCollapsableWindow"
require("AUDInit")
AUD.FileBrowser = {}
AUD.FileBrowser.FavFileList = {}


local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

CustomLuaFileBrowser = ISCollapsableWindow:derive("CustomLuaFileBrowser");
CustomLuaFileBrowserList = ISScrollingListBox:derive("CustomLuaFileBrowserList")

local browserModeIsFav = true

function CustomLuaFileBrowser:initialise()
    ISCollapsableWindow.initialise(self);
    self.title = "Lua File Manager";
end


function CustomLuaFileBrowser:onMouseDoubleClickFile(item)
    if not item then return end
    reloadLuaFile(item)
end


function CustomLuaFileBrowser:update()
    local text = string.trim(self.textEntry:getInternalText());

    if text ~= self.lastText then
       self:fill();
       self.lastText = text;
    end

    self:updateReloadButton();
end

function CustomLuaFileBrowserList:doDrawItem(y, item, alt)
    if y + self:getYScroll() >= self.height then return y + item.height end
    if y + item.height + self:getYScroll() <= 0 then return y + item.height end

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight-1, 0.3, 0.7, 0.35, 0.15);

    end
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    
    self:drawText(item.text, 15, y + (item.height - self.fontHgt) / 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    y = y + self.itemheight;
    return y;

end

function CustomLuaFileBrowser:fill()
    self.fileList:clear();

    if browserModeIsFav then
        for i=1, #AUD.FileBrowser.FavFileList do 
            local path = AUD.FileBrowser.FavFileList[i]
            local name = getShortenedFilename(path)
            self.fileList:addItem(name, path)
        end
    else
        local c = getLoadedLuaCount();

        for i = 0, c-1 do
            local path = getLoadedLua(i);
            local name = getShortenedFilename(path);
            if string.trim(self.textEntry:getInternalText()) == nil or string.contains(string.lower(name), string.lower(string.trim(self.textEntry:getInternalText()))) then
                self.fileList:addItem(name, path);
            end
        end
    end
end

function CustomLuaFileBrowserList:onMouseWheel(del)
    self:setYScroll(self:getYScroll() - (del*self.itemheight*6));
    return true;
end

function CustomLuaFileBrowser:updateReloadButton()
    local x,y = self.fileList:getMouseX(), self.fileList:getMouseY()
    local row = self.fileList:isMouseOver() and self.fileList:rowAt(x, y) or -1
    if row == self.buttonReloadRow then return end
    if row == -1 then
        self.buttonReload:setVisible(false)
    else
        self.buttonReload:setVisible(true)
        self.buttonReload:setX(self.width - self.buttonReload.width - 30)
        local itemY = self.fileList:topOfItem(row)
        self.buttonReload:setY(itemY + self.fileList:getYScroll())
    end
    self.buttonReloadRow = row
end

function CustomLuaFileBrowser:onButtonReload()
    if self.buttonReloadRow == -1 then return end
    local item = self.fileList.items[self.buttonReloadRow]
    if not item then return end

    table.insert(AUD.FileBrowser.FavFileList, item.item)
    AUD.FileBrowser.WriteFavFileList()
end

function CustomLuaFileBrowser:onButtonToggleList()
    browserModeIsFav = not browserModeIsFav
    self:fill()
end

function CustomLuaFileBrowser:createChildren()
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight()
    local rh = self:resizeWidgetHeight()
    local entryHgt = FONT_HGT_SMALL + 2 * 2

    self.fileList = CustomLuaFileBrowserList:new(0, th + entryHgt, self.width, self.height - th - rh - entryHgt*2 - 4);
    self.fileList.anchorRight = true;
    self.fileList.anchorBottom = true;
    self.fileList:initialise();
    self.fileList:setOnMouseDoubleClick(self, CustomLuaFileBrowser.onMouseDoubleClickFile);
    self.fileList:setFont(UIFont.Small, 3)
    self:addChild(self.fileList);

    self.textEntry = ISTextEntryBox:new("", 0, th, self.width, entryHgt);
    self.textEntry:initialise();
    self.textEntry:instantiate();
    self.textEntry:setClearButton(true)
    self.textEntry:setText("");
    self:addChild(self.textEntry);
    self.lastText = self.textEntry:getInternalText();

    local button = ISButton:new(self.width/2 - 100, self.fileList.y + self.fileList.height, 200, self.fileList.itemheight, "Open All", self, self.onButtonToggleList)
    button:initialise()
    self:addChild(button);

    self:fill();

    local button = ISButton:new(0, 0, 50, self.fileList.itemheight, "RELOAD", self, self.onButtonReload)
    button:initialise()
    self.fileList:addChild(button)
    self.fileList.doRepaintStencil = true
    button:setVisible(false)
    self.buttonReload = button
end


function CustomLuaFileBrowser:new(x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    return o
end


-----------------

function AUD.FileBrowser.ReadFavFileList()
    return {}
end

function AUD.FileBrowser.WriteFavFileList()
    
end


AUD.FileBrowser.FavFileList = AUD.FileBrowser.ReadFavFileList()

