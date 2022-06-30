ResourceSetEnable("WalkingDead404");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("Menu");
ResourceSetEnable("Project");

require("MenuUtils.lua")
require("Credits.lua")
require("ClickText.lua")
require("Menu_ListMenu.lua")
require("UI_Header.lua")
require("UI_TextWidget.lua")

ALIVE_Menu_AreCreditsRunning = false;
ALIVE_Menu_CreditsMusic = nil;
ALIVE_Menu_MenuMusicFile = "mus_401_alvinJunior.ogg"
ALIVE_Menu_CreditsMusicFile = "mus_alive_credits.wav"

mScene = "ui_menuMain.scene";
cancelCredits = false;

--[[
Exit to Definitive Edition - Includes Popup Modal
--]] 
ALIVE_Menu_ExitToDefinitive = function()
    WidgetInputHandler_EnableInput(false)
    
    local toReturn = DialogBox_YesNo("Are you sure you want to return to the Definitive Edition menu? All unsaved progress will be lost.", "Exit to Definitive Menu")
    
    if (toReturn) then
        ChorePlayAndWait("ui_alphaGradient_hide");
        SubProject_Switch("Menu", "Menu_Main");
    else
        WidgetInputHandler_EnableInput(true);
    end
end

--[[
Exit to Alive Inside Main Menu - Includes Popup Modal
--]] 
ALIVE_Menu_ExitToMainMenu = function()
    WidgetInputHandler_EnableInput(false)
    
    local toReturn = DialogBox_YesNo("Are you sure you want to return to the main menu? All unsaved progress will be lost.", "Exit to Main Menu")
    
    if (toReturn) then
        ChorePlayAndWait("ui_alphaGradient_hide");
        SubProject_Switch("Menu", "ALIVE_Level_MainMenu.lua");
    else
        WidgetInputHandler_EnableInput(true);
    end 
end 

--[[
Exit to Root Menu - ONLY TO BE USED IN SUBMENUS
--]] 
ALIVE_Menu_ReturnToRootMenu = function()
  Menu_Pop();
  Menu_Push(ALIVE_Menu_ActiveMenuAgent);
  Menu_Show(ALIVE_Menu_ActiveMenuAgent);
end

--[[
"Menu not yet implemented" error dialog
--]] 
ALIVE_Menu_NotYetImplemented = function()
  WidgetInputHandler_EnableInput(false)
  DialogBox_Okay("This menu hasn't been implemented yet!", "Whoops!")
  WidgetInputHandler_EnableInput(true)
end

ALIVE_Menu_ShowMenu = function(menuTS)
  Menu_Pop();
  Menu_Push(menuTS);
  Menu_Show(menuTS);
end