function MainScreen:onClickVersionDetail()
    if not (MainScreen.instance and MainScreen.instance.inGame) then
        getCore():ResetLua("default", "Force")        
    end
end

