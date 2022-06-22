--Enable requisite ResourceSets
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("Project");
ResourceSetEnable("Menu");
ResourceSetEnable("WalkingDead404");

require("ALIVE_Core_Math.lua");
require("ALIVE_Core_Utilities.lua");
require("ALIVE_Core_AgentExtensions_Properties.lua");
require("ALIVE_Core_AgentExtensions_Transform.lua");
require("ALIVE_Core_AgentExtensions_Utillity.lua");
require("ALIVE_Core_Color.lua");
require("ALIVE_Core_Strings.lua");
require("ALIVE_Core_Printing.lua");
require("ALIVE_Core_PropertyKeys.lua");
require("ALIVE_Core_DepthOfFieldAutofocus.lua");
require("ALIVE_Development_Freecam.lua");
require("ALIVE_Development_AgentBrowser.lua");
require("ALIVE_Core_Project.lua");
require("ALIVE_Core_MenuUtils.lua");
require("ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm.lua");
require("ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm.lua");

--Project//Menu
require("UI_ListButton.lua")
require("UI_ListButtonLite.lua")
require("UI_Legend.lua")
require("UI_Popup.lua")
require("Utilities.lua")
require("MenuUtils.lua")
require("RichPresence.lua")
require("AspectRatio.lua")

--Engine Scene Variables
local kScript = "ALIVE_Level_MainMenu"
local kScene = "ui_menuMain.scene" --adv_boardingSchoolDorm
local keyArtScene = "adv_boardingSchoolDorm"
local kSceneObj = kScene .. ".scene"

local menuCamera = nil;

--Cutscene Development Variables
ALIVE_Development_SceneObject = keyArtScene;
ALIVE_Development_SceneObjectAgentName = keyArtScene .. ".scene";
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = false;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = keyArtScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = keyArtScene .. ".scene";
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;
ALIVE_DOF_AUTOFOCUS_UseLegacyDOF = false;
ALIVE_DOF_AUTOFOCUS_UseHighQualityDOF = true;

ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = 
{
    "FuckinDontRemoveThis"
};

ALIVE_DOF_AUTOFOCUS_ObjectEntries =
{
    "ALIVE_MainMenuClemHat"
};

ALIVE_DOF_AUTOFOCUS_Settings =
{
    TargetValidation_IsOnScreen = false,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = false,
    TargetValidation_IsFacingCamera = false,
    TargetValidation_IsOccluded = false
};

ALIVE_DOF_AUTOFOCUS_BokehSettings =
{
    BokehBrightnessDeltaThreshold = 0.1,
    BokehBrightnessThreshold = 0.1,
    BokehBlurThreshold = 0.1,
    BokehMinSize = 0.0,
    BokehMaxSize = 0.05,
    BokehFalloff = 0.30,
    MaxBokehBufferAmount = 1.0,
    BokehPatternTexture = "bokeh_circle5.d3dtx"
};

ALIVE_DOF_AUTOFOCUS_ManualSettings =
{
    ManualOnly = true,
    NearFocusDistance = 2.0,
    NearFallof = 0.25,
    NearMax = 0.5,
    FarFocusDistance = 2.25,
    FarFalloff = 0.25,
    FarMax = 0.25
};

ALIVE_MainMenu_PrepareCamera = function()
    local camProp = "module_camera.prop";
    local camPosition = Vector(15.05, 1, -4.32);
    local camRotation = Vector(0, 90, 0);
    
    menuCamera = AgentCreate("ALIVE_MainMenuCamera", camProp, camPosition, camRotation, keyArtScene, false, false);
    
    ALIVE_SetAgentPosition("cam_ui_menuMain", camPosition)
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Far", 2500, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Near", 0.05, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Lens - Current Lens", nil, keyArtScene);
    ALIVE_RemovingAgentsWithPrefix(keyArtScene, "cam_");
    CameraPush("ALIVE_MainMenuCamera");
end

ALIVE_MainMenu_PrepareAgents = function()
    local clemHat = AgentCreate("ALIVE_MainMenuClemHat", "obj_capClementine400.prop", Vector(17.12, 0.82, -4.32), Vector(-5, -65.7, 0), keyArtScene, false, false)
end

ALIVE_MainMenu_CreateAndPopulateMenu = function()
    local menu = Menu_Create(ListMenu, "ui_menuMain", kScene)
    menu.align = "left"
    menu.background = {}

    menu.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        RichPresence_Set("richPresence_mainMenu", false)
        ALIVE_Menu_UpdateLegend();
    end

    menu.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    menu.Populate = function(self) --Populate the menu here. Add buttons & everything functional.
        local buttonPlay =  Menu_Add(ListButtonLite, "play", "Play", "ALIVE_PlayGame()")
        AgentSetProperty(buttonPlay.agent, "Text Glyph Scale", 1.5);

        Menu_Add(ListButtonLite, "settings", "Settings", "ALIVE_MainMenu_Settings()")
        Menu_Add(ListButtonLite, "credits", "Credits", "ALIVE_MainMenu_Credits()")
        Menu_Add(ListButtonLite, "definitive", "Definitive Menu", "ALIVE_Menu_ExitToDefinitive()")
        if IsPlatformPC() or IsPlatformMac() then
            Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        end

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(menu.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    menu.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end

    Menu_Push(menu); --This is vitally important. Fixes alignment bug. -Violet 
    Menu_Show(menu);
end

ALIVE_MainMenu_PrepareMenu = function() --Boilerplate to ensure there are no scaling issues or visual inconsistencies.
    if Input_UseTouch() then
        ClickText_Enable(true)
    end
    local prefs = GetPreferences()
    if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
        RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
        PropertyRemove(prefs, "Menu - User Gamma Setting")
        SavePrefs()
    end
    RenderForce_16_by_9_AspectRatio(true)
    RenderDelay(1)
    WaitForNextFrame()
    MenuUtils_AddScene(keyArtScene);
    ALIVE_MainMenu_CreateAndPopulateMenu();
end

ALIVE_Level_MainMenu = function()
    ALIVE_Core_Project_SetProjectSettings();

    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        MenuUtils_AddScene(keyArtScene);
        --ALIVE_PrintSceneListToTXT(keyArtScene, "adv_boardingSchoolDorm404.txt");

        ALIVE_MainMenu_PrepareAgents();

        ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
        ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);

        --ALIVE_Camera_DepthOfFieldAutofocus_SetupDOF(keyArtScene);
        --Callback_OnPostUpdate:Add(ALIVE_Camera_DepthOfFieldAutofocus_PerformAutofocus);
    else --Build menu as normal.
        ALIVE_MainMenu_PrepareMenu();
        ALIVE_MainMenu_PrepareAgents();
        ALIVE_MainMenu_PrepareCamera();

        ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
        ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

        ALIVE_Camera_DepthOfFieldAutofocus_SetupDOF(keyArtScene);
        Callback_OnPostUpdate:Add(ALIVE_Camera_DepthOfFieldAutofocus_PerformAutofocus);
    end
end

SceneOpen(kScene,kScript)