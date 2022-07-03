local kScene = "";
local mScene = "ui_menuMain.scene";

ResourceSetEnable("Project");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("Menu");

require("Utilities.lua")
require("MenuUtils.lua")
require("RichPresence.lua")
require("AspectRatio.lua")

require("ALIVE_Core_Inclusions.lua");
require("ALIVE_Menu_Pause.lua");
require("ALIVE_Menu_Settings.lua");
require("ALIVE_Menu_About.lua");

ALIVE_Gameplay_Player_ThirdPerson_UI_Init = function(scene)
    if scene == nil then
        return false
    end
    
    kScene = scene;

    SceneSetRenderPriority(mScene, 9999)
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
        isSceneHidden = not isSceneHidden;
        print("GAME PAUSED " .. gamePausedIncrements);
        gamePausedIncrements = gamePausedIncrements + 1;
        print(kScene);
        SceneHide(kScene .. ".scene", isSceneHidden);
        ALIVE_Menu_CreatePauseMenu(mScene);
    elseif not pause_isPressed and pauseWasPressedLastFrame then
        --Game_PopMode(eModeMenu);
        ThreadStart(ALIVE_Gameplay_Player_ThirdPerson_UI_FixBecauseToolIsPoo);
        pauseWasPressedLastFrame = false;
    end
end