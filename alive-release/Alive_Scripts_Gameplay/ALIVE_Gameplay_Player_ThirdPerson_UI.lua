local kScene = "";

ALIVE_Gameplay_Player_ThirdPerson_UI_Init = function(scene)
    if scene == nil then
        return false
    end
    
    kScene = scene;

    return true;
end


require("ALIVE_Core_Inclusions.lua");

pauseWasPressedLastFrame = false;
isSceneHidden = false;
gamePausedIncrements = 1;


ALIVE_Gameplay_Player_ThirdPerson_UI_FixBecauseToolIsPoo = function()

end

ALIVE_Gameplay_Player_ThirdPerson_UI_UpdateUI = function()
    local pause_isPressed = Input_IsVKeyPressed(27);

    if pause_isPressed and not pauseWasPressedLastFrame then
        pauseWasPressedLastFrame = true;
        print("GAME PAUSED " .. gamePausedIncrements);
        gamePausedIncrements = gamePausedIncrements + 1;
        print(kScene);
        SceneHide(kScene, not isSceneHidden);
        isSceneHidden = not isSceneHidden;
    elseif not pause_isPressed and pauseWasPressedLastFrame then
        --Game_PopMode(eModeMenu);
        ThreadStart(ALIVE_Gameplay_Player_ThirdPerson_UI_FixBecauseToolIsPoo);
        pauseWasPressedLastFrame = false;
    end
end