--Enable requisite ResourceSets
ResourceSetEnable("Project");
ResourceSetEnable("ProjectSeason1");
ResourceSetEnable("ProjectSeason4");
ResourceSetEnable("WalkingDead404");
ResourceSetEnable("Menu");

require("ALIVE_Core_Inclusions.lua");
require("ALIVE_Menu_Main.lua")
require("ALIVE_Menu_Pause.lua");
require("ALIVE_Menu_Credits.lua");
require("ALIVE_Menu_Settings.lua");
require("ALIVE_Cutscene_HandheldCameraAnimation.lua");
require("ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm.lua");
require("ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm.lua");

--Engine Scene Variables
local kScript = "ALIVE_Level_MainMenu"
local kScene = "ui_menuMain.scene" --adv_boardingSchoolDorm
local keyArtScene = "adv_boardingSchoolDorm.scene"
local menuCamera = nil;

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
    BokehMaxSize = 0.03,
    BokehFalloff = 0.75,
    MaxBokehBufferAmount = 1.0,
    BokehPatternTexture = "bokeh_circle.d3dtx"
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
    ALIVE_Menu_ActiveMenuSound = SoundPlay(ALIVE_Menu_MenuMusicFile);
    --ALIVE_Menu_ActiveMenuSound = SoundPlay("mus_loop_AJ_01a.wav"); --what it should be (davids a dum dum)
    ControllerSetLooping(ALIVE_Menu_ActiveMenuSound, true);
end

ALIVE_MainMenu_PrepareMenu = function() --Boilerplate to ensure there are no scaling issues or visual inconsistencies.
    if Input_UseTouch() then
        ClickText_Enable(true)
    end

    local isBlindMode = false;

    local prefs = GetPreferences();

    if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
        RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
        PropertyRemove(prefs, "Menu - User Gamma Setting")
        SavePrefs()
    end

    RenderForce_16_by_9_AspectRatio(true)
    RenderDelay(1)
    WaitForNextFrame()

    --if not ALIVE_FileUtils_OptionsFile.screenReaderCompat then
        MenuUtils_AddScene(keyArtScene);
    --    isBlindMode = true;
    --end

    --perform the cleanup/relight on the key art scene
    ALIVE_Scene_LevelCleanup_404_BoardingSchoolDorm(keyArtScene);
    ALIVE_Scene_LevelRelight_404_BoardingSchoolDorm_MainMenu(keyArtScene);

    ALIVE_Menu_CreateMainMenu(kScene);

    --return not isBlindMode;
    return true;
end

ALIVE_Level_MainMenu = function()
    ALIVE_Core_Project_SetProjectSettings();

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
        
        if not ALIVE_MainMenu_PrepareMenu() then
            return
        end
        
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

if not ALIVE_FileUtils_IsCurrentlyInitialized then
        ALIVE_Core_FileUtils_Init();
end

SceneOpen(kScene,kScript)