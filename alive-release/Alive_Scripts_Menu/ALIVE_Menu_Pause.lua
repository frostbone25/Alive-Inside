require("ALIVE_Core_Inclusions.lua");

local kScene = nil;

ALIVE_Menu_CreatePauseMenu = function(scene)
  
  kScene = scene;
  print("Scene provided to menu is " .. kScene);

  local PauseMenu = Menu_Create(ListMenu, "ui_menuMain", kScene) 
  PauseMenu.align = "left"
  PauseMenu.background = {}

    PauseMenu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        ALIVE_Menu_UpdateLegend();
    end

    PauseMenu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    PauseMenu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.

        print("Pause Menu - Reached Milestone: Populate Menu");

        local header = Menu_Add(Header, nil, "Alive Inside")
        AgentSetProperty(header.agent, "Text Glyph Scale", 1.5);

        local buttonPlay =  Menu_Add(ListButtonLite, "back", "Back to Game", "ALIVE_PauseMenu_ExitMenu()") --ALIVE_Menu_Configurator()

        Menu_Add(ListButtonLite, "settings", "Settings", "ALIVE_Menu_CreateSettingsMenu()")
        Menu_Add(ListButtonLite, "quitMenu", "Exit to Main Menu", "ALIVE_Menu_ExitToMainMenu()")
        if IsPlatformPC() or IsPlatformMac() then
            Menu_Add(ListButtonLite, "exit", "Exit to Desktop", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        end
        
        print("Population Complete!");

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(PauseMenu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    PauseMenu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end
    
    print("Pause Menu - Reached Milestone: Pop / Push");
    ALIVE_Menu_ActiveMenuAgent = PauseMenu;
    ALIVE_Menu_IsPauseMenuActive = true;
    ALIVE_Menu_ShowMenu(PauseMenu, true);
    return true;
end

ALIVE_PauseMenu_ExitMenu = function()
    print("exit");
end