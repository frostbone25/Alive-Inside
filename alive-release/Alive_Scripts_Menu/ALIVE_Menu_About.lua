require("ALIVE_Menu_MenuUtils.lua");
require("UI_Header.lua")
require("UI_TextWidget.lua")

local kAboutTextProp = "ui_aboutText.prop"
local kAboutTextBigProp = "ui_aboutTextBig.prop"

local kAboutTextProp = "ui_aboutText.prop"
local kAboutTextBigProp = "ui_aboutTextBig.prop"

AboutTextWidget = Class(TextWidget)
AboutTextWidget.propFile = IsPlatformSmallScreen() and kAboutTextBigProp or kAboutTextProp

ALIVE_Menu_CreateAboutMenu = function()
  local AboutMenu = Menu_Create(ListMenu, "ui_menuAbout", mScene) 
  AboutMenu.align = "left"
  AboutMenu.background = {}

    AboutMenu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        ALIVE_Menu_UpdateLegend();
    end

    AboutMenu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    AboutMenu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.
        print("About - Reached Milestone: Populate Menu");

        
        local header = Menu_Add(Header, nil, "About Alive Inside");
        AgentSetProperty(header.agent, "Text Glyph Scale", 1.5);
        
        local aboutText = ALIVE_Menu_AboutText;
        aboutText = string.gsub(aboutText, "{BUILD_VERSION}", PlatformGetBuildVersion())
        aboutText = string.gsub(aboutText, "{ENGINE_VERSION}", EngineGetVersion())
        aboutText = string.gsub(aboutText, "{MOD_VERSION}", ALIVE_Core_Project_Version)
        local textBodyWidget = Menu_Add(AboutTextWidget, "body", aboutText)
        AgentSetProperty(textBodyWidget.agent, "Text Alignment Horizontal", MenuUtils_GetHorizontalTextAlignmentFromAgentAlignment(AboutMenu.align))

        Menu_Add(ListButtonLite, "about_back", "Back", "ALIVE_Menu_CreateSettingsMenu()");
        print("Population Complete!");

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(AboutMenu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    AboutMenu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end
    
    print("About - Reached Milestone: Pop / Push");
    ALIVE_Menu_ShowMenu(AboutMenu);
end 

ALIVE_Menu_AboutText = [[
    Copyright (C) 2020-22 Telltale Modding Group. Alive Inside is a fan project, created wholly without profit.

    Telltale Modding Group is not endorsed by or otherwise associated with Telltale Games, Skybound Entertainment, or their affiliates.

    Game Build Version: {BUILD_VERSION}
    Mod Build Version: {MOD_VERSION}
    Engine Version: {ENGINE_VERSION}
]]