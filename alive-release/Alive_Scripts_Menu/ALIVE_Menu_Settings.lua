require("ALIVE_Menu_MenuUtils.lua");
require("ALIVE_Menu_About.lua")

ALIVE_Menu_CreateSettingsMenu = function()
  local SettingsMenu = Menu_Create(ListMenu, "ui_menuSettings", mScene) 
  SettingsMenu.align = "left"
  SettingsMenu.background = {}

    SettingsMenu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        ALIVE_Menu_UpdateLegend();
    end

    SettingsMenu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    SettingsMenu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.

        print("Settings - Reached Milestone: Populate Menu");

        --local header = Menu_Add(Header, nil, "Settings");
        --AgentSetProperty(header.agent, "Text Glyph Scale", 1.5);
        Menu_Add(ListButtonLite, "settings_audio", "Audio", "ALIVE_Menu_NotYetImplemented()");
        Menu_Add(ListButtonLite, "settings_controls", "Controls", "ALIVE_Menu_NotYetImplemented()");
        Menu_Add(ListButtonLite, "settings_access", "Accessibility", "ALIVE_Menu_NotYetImplemented()");
        Menu_Add(ListButtonLite, "settings_about", "About", "ALIVE_Menu_CreateAboutMenu()");
        Menu_Add(ListButtonLite, "settings_back", "Back", "ALIVE_Menu_ReturnToRootMenu()");
        
        print("Population Complete!");

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(SettingsMenu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    SettingsMenu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end
    
    print("Settings - Reached Milestone: Pop / Push");
    ALIVE_Menu_ShowMenu(SettingsMenu);
end