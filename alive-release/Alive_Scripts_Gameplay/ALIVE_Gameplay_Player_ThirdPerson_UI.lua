local kScene = "";
local mScene = "ui_menuMain.scene";

ResourceSetEnable("Project");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("Menu");

require("Utilities.lua")
require("MenuUtils.lua")
require("RichPresence.lua")
require("AspectRatio.lua")

--require("ALIVE_Core_Inclusions.lua");
--require("ALIVE_Menu_Pause.lua");
--require("ALIVE_Menu_Settings.lua");
--require("ALIVE_Menu_About.lua");

ALIVE_Gameplay_Player_ThirdPerson_UI_Init = function(scene)
    return false;
end

--require("ALIVE_Core_Inclusions.lua");
pauseWasPressedLastFrame = false;
isSceneHidden = false;
gamePausedIncrements = 1;


ALIVE_Gameplay_Player_ThirdPerson_UI_FixBecauseToolIsPoo = function()

end

ALIVE_Gameplay_Player_ThirdPerson_UI_UpdateUI = function()
end