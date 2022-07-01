require("ALIVE_Core_Inclusions.lua");

local kScene = nil;

ALIVE_Menu_CreateMainMenu = function(scene)
  
  kScene = scene;

  local MainMenu = Menu_Create(ListMenu, "ui_menuMain", kScene) 
  MainMenu.align = "left"
  MainMenu.background = {}

    MainMenu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        RichPresence_Set("richPresence_mainMenu", false)
        ALIVE_Menu_UpdateLegend();
    end

    MainMenu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    MainMenu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.

        print("Main Menu - Reached Milestone: Populate Menu");

        if not ALIVE_FileUtils_IsCurrentlyInitialized then
            ALIVE_Core_FileUtils_Init();
        end

        local topText = "";

        --If Checkpoint State is "Not Started" or "Game Complete"
        if ALIVE_FileUtils_ActiveSave.checkpoint == 0 then
            topText = "New Game"
        elseif ALIVE_FileUtils_ActiveSave.checkpoint == 99 then
            topText = "Restart"
        else
            topText = "Continue"
        end

        local buttonPlay =  Menu_Add(ListButtonLite, "play", topText, "ALIVE_MainMenu_Play()") --ALIVE_Menu_Configurator()
        AgentSetProperty(buttonPlay.agent, "Text Glyph Scale", 1.5);

        Menu_Add(ListButtonLite, "settings", "Settings", "ALIVE_Menu_CreateSettingsMenu()")
        Menu_Add(ListButtonLite, "credits", "Credits", "ALIVE_MainMenu_LaunchCredits()")
        Menu_Add(ListButtonLite, "definitive", "Definitive Menu", "ALIVE_Menu_ExitToDefinitive()")
        if IsPlatformPC() or IsPlatformMac() then
            Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        end
        
        print("Population Complete!");

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(MainMenu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    MainMenu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end
    
    print("Main Menu - Reached Milestone: Pop / Push");
    ALIVE_Menu_ActiveMenuAgent = MainMenu;
    ALIVE_Menu_IsMainMenuActive = true;
    ALIVE_Menu_ShowMenu(MainMenu, true);
    return true;
end

ALIVE_MainMenu_LaunchCredits = function()
    if not ALIVE_Menu_PlayCredits() then
        DialogBox_Okay("The credits are already running.", "Error");
    end
end

ALIVE_MainMenu_Play = function()
    WidgetInputHandler_EnableInput(false)
    Menu_Pop()
    Sleep(0.5)
    
    if ALIVE_FileUtils_ActiveSave.checkpoint == 0 then
            ALIVE_Menu_Configurator(ALIVE_Menu_ActiveMenuAgent, false)
    elseif ALIVE_FileUtils_ActiveSave.checkpoint == 99 then
            ALIVE_Menu_Configurator(ALIVE_Menu_ActiveMenuAgent, true)
    else
            SubProject_Switch("Menu", "ALIVE_Level_VioletSandbox.lua")
   end
end
