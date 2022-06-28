--Enable requisite ResourceSets
ResourceSetEnable("Project");
ResourceSetEnable("ProjectSeason1");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("Menu");

require("ALIVE_Core_Inclusions.lua");
require("ALIVE_Cutscene_HandheldCameraAnimation.lua");
require("ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm.lua");
require("ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm.lua");

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
local keyArtScene = "adv_boardingSchoolDorm.scene"
local kSceneObj = kScene .. ".scene"

local menuCamera = nil;
local bgMusic = nil;

ALIVE_Menu_ActiveMenuAgent = nil;
ALIVE_Menu_ActiveMenuSound = nil;
ALIVE_Menu_IsMainMenuActive = false;

--Cutscene Development Variables
ALIVE_Development_SceneObject = keyArtScene;
ALIVE_Development_SceneObjectAgentName = keyArtScene;
ALIVE_Development_UseSeasonOneAPI = false;
ALIVE_Development_FreecamUseFOVScale = false;

local EnableFreecamTools = false;
local EnablePerformanceMetrics = false;

--DOF Autofocus Variables
ALIVE_DOF_AUTOFOCUS_SceneObject = keyArtScene;
ALIVE_DOF_AUTOFOCUS_SceneObjectAgentName = keyArtScene;
ALIVE_DOF_AUTOFOCUS_UseCameraDOF = true;
ALIVE_DOF_AUTOFOCUS_UseLegacyDOF = false;
ALIVE_DOF_AUTOFOCUS_UseHighQualityDOF = true;
ALIVE_DOF_AUTOFOCUS_GameplayCameraNames = { "FuckinDontRemoveThis" };
ALIVE_DOF_AUTOFOCUS_ObjectEntries = { "ALIVE_MainMenuClemHat" };
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

local MenuCameraPosition = Vector(15.05, 1, -4.32);
local MenuCameraRotation = Vector(0, 90, 0);

local ApplyHandheldCameraAnimation = function()
    local newCamPosition = MenuCameraPosition;
    local newCamRotation = MenuCameraRotation;

    newCamPosition = newCamPosition + ALIVE_Cutscene_HandheldCameraAnimation_CurrentPos;
    newCamRotation = newCamRotation + ALIVE_Cutscene_HandheldCameraAnimation_CurrentRot;

    --ALIVE_SetAgentPosition("ALIVE_MainMenuCamera", newCamPosition, keyArtScene);
    ALIVE_SetAgentRotation("ALIVE_MainMenuCamera", newCamRotation, keyArtScene);
end

ALIVE_MainMenu_PrepareCamera = function()
    local camProp = "module_camera.prop";

    menuCamera = AgentCreate("ALIVE_MainMenuCamera", camProp, MenuCameraPosition, MenuCameraRotation, keyArtScene, false, false);
    
    ALIVE_SetAgentPosition("cam_ui_menuMain", MenuCameraPosition)
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Far", 2500, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Clip Plane - Near", 0.05, keyArtScene);
    ALIVE_AgentSetProperty("ALIVE_MainMenuCamera", "Lens - Current Lens", nil, keyArtScene);
    ALIVE_RemovingAgentsWithPrefix(keyArtScene, "cam_");
    CameraPush("ALIVE_MainMenuCamera");
end

ALIVE_MainMenu_PrepareAgents = function()

    local clemHat = AgentCreate("ALIVE_MainMenuClemHat", "obj_capClementine400.prop", Vector(17.12, 0.8125, -4.32), Vector(-2, -65.7, 0), keyArtScene, false, false)
    --local bgMusic = SoundPlay("mus_loop_clementine_04.wav");
    --local bgMusic = SoundPlay("mus_loop_clementine_03.wav");
    --local bgMusic = SoundPlay("mus_loop_clementine_01.wav"); --the real shit
    --local bgMusic = SoundPlay("music_custom1.wav"); --flashvolts "credits" track
    ALIVE_Menu_ActiveMenuSound = SoundPlay("mus_401_alvinJunior.ogg");
    --ALIVE_Menu_ActiveMenuSound = SoundPlay("mus_loop_AJ_01a.wav"); --what it should be (davids a dum dum)
    ControllerSetLooping(ALIVE_Menu_ActiveMenuSound, true);
end

ALIVE_MainMenu_LaunchConfigurator = function()
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

ALIVE_MainMenu_LaunchCredits = function()
    if not ALIVE_Menu_PlayCredits() then
        DialogBox_Okay("The credits are already running.", "Error");
    end
end

ALIVE_MainMenu_CreateAndPopulateMenu = function()
    ALIVE_Menu_IsMainMenuActive = true;
    ALIVE_Menu_ActiveMenuAgent = Menu_Create(ListMenu, "ui_menuMain", kScene)
    ALIVE_Menu_ActiveMenuAgent.align = "left"
    ALIVE_Menu_ActiveMenuAgent.background = {}

    ALIVE_Menu_ActiveMenuAgent.Show = function(self, direction) --Ran on menu show.
        if direction and direction < 0 then
            ChorePlay("ui_alphaGradient_show")
        end
        ;
        (Menu.Show)(self)
        RichPresence_Set("richPresence_mainMenu", false)
        ALIVE_Menu_UpdateLegend();
    end

    ALIVE_Menu_ActiveMenuAgent.Hide = function(self, direction) --Ran on menu hide.
        ChorePlay("ui_alphaGradient_hide")
        ;
        (Menu.Hide)(self)
    end

    ALIVE_Menu_ActiveMenuAgent.Populate = function(self) --Populate the menu here. Add buttons & everything functional.

        local topText = "";

        --If Checkpoint State is "Not Started" or "Game Complete"
        if ALIVE_FileUtils_ActiveSave.checkpoint == 0 then
            topText = "New Game"
        elseif ALIVE_FileUtils_ActiveSave.checkpoint == 99 then
            topText = "Restart"
        else
            topText = "Continue"
        end

        local buttonPlay =  Menu_Add(ListButtonLite, "play", topText, "ALIVE_MainMenu_LaunchConfigurator()") --ALIVE_Menu_Configurator()
        AgentSetProperty(buttonPlay.agent, "Text Glyph Scale", 1.5);

        Menu_Add(ListButtonLite, "settings", "Settings", "ALIVE_Menu_CreateSettingsMenu()")
        Menu_Add(ListButtonLite, "credits", "Credits", "ALIVE_MainMenu_LaunchCredits()")
        Menu_Add(ListButtonLite, "definitive", "Definitive Menu", "ALIVE_Menu_ExitToDefinitive()")
        if IsPlatformPC() or IsPlatformMac() then
            Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
        end

        local legendWidget = Menu_Add(Legend)
        legendWidget.Place = function(self)
            self:AnchorToAgent(ALIVE_Menu_ActiveMenuAgent.agent, "left", "bottom")
        end
        ALIVE_Menu_UpdateLegend();
    end

    ALIVE_Menu_ActiveMenuAgent.onModalPopped = function(self)
        (Menu.onModalPopped)(self)
        ALIVE_Menu_UpdateLegend()
    end

    Menu_Push(ALIVE_Menu_ActiveMenuAgent); --This is vitally important. Fixes alignment bug. -Violet 
    Menu_Show(ALIVE_Menu_ActiveMenuAgent);
end

ALIVE_MainMenu_PrepareMenu = function() --Boilerplate to ensure there are no scaling issues or visual inconsistencies.
    if Input_UseTouch() then
        ClickText_Enable(true)
    end

    local prefs = GetPreferences();

    if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
        RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
        PropertyRemove(prefs, "Menu - User Gamma Setting")
        SavePrefs()
    end

    RenderForce_16_by_9_AspectRatio(true)
    RenderDelay(1)
    WaitForNextFrame()
    MenuUtils_AddScene(keyArtScene);

    --perform the cleanup/relight on the key art scene
    ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
    ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

    ALIVE_MainMenu_CreateAndPopulateMenu();
end

ALIVE_Level_MainMenu = function()
    ALIVE_Core_Project_SetProjectSettings();
    ALIVE_Core_FileUtils_Init();

    if (ALIVE_Core_Project_IsDebugMode) and (EnableFreecamTools) then
        --add the key art scene so we can fly around within it
        MenuUtils_AddScene(keyArtScene);
        ALIVE_MainMenu_PrepareAgents();

        --perform the cleanup/relight on the key art scene
        ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
        ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

        --Initialize tools
        ALIVE_Development_CreateFreeCamera();
        ALIVE_Development_InitalizeCutsceneTools();

        --Add required callbacks
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(ALIVE_Development_UpdateCutsceneTools_Main);

    else --Build menu as normal.
        ALIVE_MainMenu_PrepareMenu();
        ALIVE_MainMenu_PrepareAgents();
        ALIVE_MainMenu_PrepareCamera();

        --get DOF setup
        ALIVE_Camera_DepthOfFieldAutofocus_SetupDOF(keyArtScene);
        Callback_OnPostUpdate:Add(ALIVE_Camera_DepthOfFieldAutofocus_PerformAutofocus); --do DOF

        --add a procedual handheld camera animation
        ALIVE_Cutscene_HandheldCameraAnimation_TotalShakeAmount = 0.15;
        ALIVE_Cutscene_HandheldCameraAnimation_TotalSpeedMultiplier = 0.75;
        ALIVE_Cutscene_HandheldCameraAnimation_ShakeLevel = 3;
        Callback_OnPostUpdate:Add(ALIVE_Cutscene_HandheldCameraAnimation_Update);
        Callback_OnPostUpdate:Add(ApplyHandheldCameraAnimation);
    end

    if (ALIVE_Core_Project_IsDebugMode) and (EnablePerformanceMetrics) then
        ALIVE_Development_PerformanceMetrics_Initalize();
        Callback_OnPostUpdate:Add(ALIVE_Development_PerformanceMetrics_Update);
    end

    --ALIVE_PrintSceneListToTXT(keyArtScene, "adv_boardingSchoolDorm404.txt");
end

SceneOpen(kScene,kScript)